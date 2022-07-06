// Copyright © 2022 Brian Drelling. All rights reserved.

#if canImport(AsyncHTTPClient)

    import AsyncHTTPClient
    import Foundation
    import NIO
    import NIOHTTP1

    public final class NIONetworkRequestDispatcher {
        public let environment: Environment
        public let decoder: JSONDecoder

        private let client: AsyncHTTPClient.HTTPClient

        public init(environment: Environment, decoder: JSONDecoder? = nil, client: AsyncHTTPClient.HTTPClient? = nil) {
            self.environment = environment
            self.decoder = decoder ?? .safeISO8601
            self.client = client ?? .init(eventLoopGroupProvider: .createNew)
        }

        public convenience init(baseURL: String, decoder: JSONDecoder? = nil, client: AsyncHTTPClient.HTTPClient? = nil) {
            self.init(environment: .init(baseURL: baseURL), decoder: decoder, client: client)
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

    // MARK: - Extensions

    private extension NIONetworkRequestDispatcher {
        func request(_ httpClientRequest: HTTPClientRequest, timeout: TimeAmount = .seconds(10)) async throws -> (Data, HTTPClientResponse) {
            let response = try await self.client.execute(httpClientRequest, timeout: timeout)

            let buffer = try await response.body.collect(upTo: 1024 * 1024) // 1 MB
            let data = Data(buffer: buffer)

            return (data, response)
        }
    }

    extension NIONetworkRequestDispatcher: NetworkRequestDispatching {
        public func request(_ request: Request) async throws -> DataResponse<Data> {
            let httpClientRequest = try request.asHTTPClientRequest(with: self.environment)
            let (data, response) = try await self.request(httpClientRequest, timeout: .seconds(Int64(self.environment.timeout ?? 10)))

            return try .init(request: request, response: response, data: data)
        }
    }

#endif
