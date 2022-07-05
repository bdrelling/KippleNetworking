// Copyright © 2022 Brian Drelling. All rights reserved.

#if canImport(AsyncHTTPClient)

    import AsyncHTTPClient
    import Foundation
    import NIO
    import NIOHTTP1

    public final class SwiftNIONetworkRequestDispatcher {
        public enum RequestError: Error {
            case missingResponseBody
            case invalidRootJSONResponseKey
        }

        public let client: AsyncHTTPClient.HTTPClient
        public let environment: Environment
        public let decoder: JSONDecoder = .safeISO8601

        public init(environment: Environment) {
            self.environment = environment
            self.client = Self.configuredClient()
        }

        deinit {
            self.client.shutdown { error in
                if let error = error {
                    // TODO: Inject error logger and handle error?
                    print(error.localizedDescription)
                }
            }
        }
    }

    extension SwiftNIONetworkRequestDispatcher: NetworkRequestDispatching {
        public func request<T: ResponseAnticipating>(_ request: T) async throws -> T.Response {
            let response = try await self.client.execute(request, with: self.environment, timeout: .seconds(10))

            let buffer = try await response.body.collect(upTo: 1024 * 1024) // 1 MB
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
        }

        public static func configuredClient() -> AsyncHTTPClient.HTTPClient {
            .init(eventLoopGroupProvider: .createNew)
        }
    }

#endif
