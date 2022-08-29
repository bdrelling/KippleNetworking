// Copyright © 2022 Brian Drelling. All rights reserved.

#if canImport(AsyncHTTPClient)

import AsyncHTTPClient
import Foundation
import Logging
import NIO
import NIOHTTP1

public final class NIONetworkRequestDispatcher {
    public let decoder: JSONDecoder

    private let client: AsyncHTTPClient.HTTPClient

    public init(decoder: JSONDecoder? = nil, client: AsyncHTTPClient.HTTPClient? = nil) {
        self.decoder = decoder ?? .safeISO8601
        self.client = client ?? .init(eventLoopGroupProvider: .createNew)
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
    public func request(_ request: Request, with environment: Environment, logger: Logger? = nil) async throws -> DataResponse<Data> {
        let httpClientRequest = try request.asHTTPClientRequest(with: environment)
        let (data, response) = try await self.request(httpClientRequest, timeout: .seconds(Int64(environment.timeout ?? 10)))

        return try .init(request: request, response: response, data: data)
    }
}

// MARK: - Convenience

public extension NetworkRequestDispatching where Self == NIONetworkRequestDispatcher {
    static var nio: Self {
        .init()
    }

    static func nio(decoder: JSONDecoder? = nil, client: AsyncHTTPClient.HTTPClient? = nil) -> Self {
        .init(decoder: decoder, client: client)
    }
}

#endif
