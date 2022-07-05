// Copyright © 2022 Brian Drelling. All rights reserved.

#if canImport(AsyncHTTPClient)

    import AsyncHTTPClient
    import Foundation
    import NIO
    import NIOHTTP1

    public final class SwiftNIONetworkRequestDispatcher {
        enum RequestError: Error {
            case missingResponseBody
            case invalidRootJSONResponseKey
        }

        let client: AsyncHTTPClient.HTTPClient
        let environment: Environment
        let decoder: JSONDecoder = .safeISO8601

        init(environment: Environment) {
            self.environment = environment
            self.client = Self.configuredClient()
        }
    }

    extension SwiftNIONetworkRequestDispatcher: NetworkRequestDispatching {
        func request<T: ResponseAnticipating>(_ request: T) async throws -> T.Response {
            #warning("Implement me!")
            throw RequestError.missingResponseBody
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

        static func configuredClient() -> AsyncHTTPClient.HTTPClient {
            .init(eventLoopGroupProvider: .createNew)
        }
    }

#endif
