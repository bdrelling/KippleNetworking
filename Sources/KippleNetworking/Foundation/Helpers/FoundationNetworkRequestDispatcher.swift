// Copyright © 2022 Brian Drelling. All rights reserved.

#if os(iOS) || os(macOS) || os(tvOS) || os(watchOS)

import Foundation

public final class FoundationNetworkRequestDispatcher {
    public let decoder: JSONDecoder

    private let session: URLSession

    public init(decoder: JSONDecoder? = nil, session: URLSession = .shared) {
        self.decoder = decoder ?? .safeISO8601
        self.session = session
    }
}

// MARK: - Extensions

private extension FoundationNetworkRequestDispatcher {
    func request(_ urlRequest: URLRequest) async throws -> (Data, URLResponse) {
        return try await self.session.data(for: urlRequest)
    }
}

extension FoundationNetworkRequestDispatcher: NetworkRequestDispatching {
    public func request(_ request: Request, with environment: Environment) async throws -> DataResponse<Data> {
        let urlRequest = try request.asURLRequest(with: environment)
        let (data, response) = try await self.request(urlRequest)

        return try .init(request: request, response: response, data: data)
    }
}

public extension NetworkRequestDispatching where Self == FoundationNetworkRequestDispatcher {
    static var foundation: Self {
        Self()
    }
}

#endif
