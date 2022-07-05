// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

#if os(iOS) || os(macOS) || os(tvOS) || os(watchOS)

    import Combine
    import UtilityBeltNetworking

    private typealias NetworkingClient = UtilityBeltNetworking.HTTPClient

#elseif os(Linux)

    import AsyncHTTPClient
    import NIO
    import NIOHTTP1

    private typealias NetworkingClient = AsyncHTTPClient.HTTPClient

#endif

public class NetworkRequestDispatcher {
    private let client: NetworkingClient
    private let environment: Environment
    private let decoder: JSONDecoder = .safeISO8601

    public init(environment: Environment) {
        self.environment = environment
        self.client = Self.configuredClient()
    }

    public convenience init(baseURL: String) {
        self.init(environment: .init(baseURL: baseURL))
    }
}

// MARK: - Extensions

#if os(iOS) || os(macOS) || os(tvOS) || os(watchOS)

    public extension NetworkRequestDispatcher {
        func request<T: ResponseAnticipating>(_ request: T) async throws -> T.Response {
            let urlRequest = try request.asURLRequest(with: self.environment)

            let (data, _) = try await URLSession.shared.data(for: urlRequest)

            print("WOWIEE")
            print(String(data: data, encoding: .utf8))

            return try self.decoder.decode(T.Response.self, from: data)
        }

        func request<T: ResponseAnticipating>(_ request: T) -> AnyPublisher<T.Response, Error> {
            let urlRequest: URLRequest

            do {
                urlRequest = try request.asURLRequest(with: self.environment)
            } catch {
                return Result<T.Response, Error>.Publisher(error)
                    .eraseToAnyPublisher()
            }

            return self.client
                .requestPublisher(urlRequest, decoder: self.decoder)
        }

        static func configuredClient() -> HTTPClient {
            .init()
        }
    }

#elseif os(Linux)

    public extension NetworkRequestDispatcher {
        enum RequestError: Error {
            case missingResponseBody
            case invalidRootJSONResponseKey
        }

        // TODO: Async! https://github.com/swift-server/async-http-client/blob/main/Examples/GetJSON/GetJSON.swift
        func request<T: ResponseAnticipating>(_ request: T) -> EventLoopFuture<T.Response> {
            self.client
                .execute(request: request, with: self.environment)
                .flatMapThrowing { response in
                    if let buffer = response.body {
                        let data = Data(buffer: buffer)

                        if let rootKey = self.environment.rootResponseKey {
                            let responseDictionary = try self.decoder.decode([String: T.Response].self, from: data)

                            if let response = responseDictionary[rootKey] {
                                return response
                            } else {
                                throw RequestError.invalidRootJSONResponseKey
                            }
                        } else {
                            return try self.decoder.decode(T.Response.self, from: data)
                        }
                    } else {
                        throw RequestError.missingResponseBody
                    }
                }
        }

        fileprivate static func configuredClient() -> HTTPClient {
            .init(eventLoopGroupProvider: .createNew)
        }
    }

#endif
