// Copyright © 2024 Brian Drelling. All rights reserved.

#if os(iOS) || os(macOS) || os(tvOS) || os(watchOS)

import Foundation
import Logging

public final class FoundationNetworkRequestDispatcher {
    public let decoder: JSONDecoder

    private let session: URLSession

    public init(decoder: JSONDecoder? = nil, session: URLSession? = nil) {
        self.decoder = decoder ?? .safeISO8601
        self.session = session ?? .shared
    }
}

// MARK: - Extensions

private extension FoundationNetworkRequestDispatcher {
    func request(_ urlRequest: URLRequest) async throws -> (Data, URLResponse) {
        try await self.session.data(for: urlRequest)
    }
}

extension FoundationNetworkRequestDispatcher: NetworkRequestDispatching {
    public func request(_ request: Request, with environment: Environment, logger: Logger? = nil) async throws -> DataResponse<Data> {
        let urlRequest = try request.asURLRequest(with: environment)
        let (data, response) = try await self.request(urlRequest)

        return try .init(request: request, response: response, data: data)
    }
}

// MARK: - Convenience

public extension NetworkRequestDispatching where Self == FoundationNetworkRequestDispatcher {
    static var foundation: Self {
        .init()
    }

    static func foundation(decoder: JSONDecoder? = nil, session: URLSession? = nil) -> Self {
        .init(decoder: decoder, session: session)
    }
}

#endif
