// Copyright © 2022 Brian Drelling. All rights reserved.

#if os(iOS) || os(macOS) || os(tvOS) || os(watchOS)

import Foundation

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
        if #available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *) {
            return try await self.session.data(for: urlRequest)
        } else {
            return try await withCheckedThrowingContinuation { continuation in
                self.session.dataTask(with: urlRequest) { data, response, error in
                    if let error = error {
                        continuation.resume(throwing: error)
                    } else if let data = data, let response = response {
                        continuation.resume(returning: (data, response))
                    } else {
                        continuation.resume(throwing: NetworkingError.unexpectedError)
                    }
                }
            }
        }
    }
}

extension FoundationNetworkRequestDispatcher: NetworkRequestDispatching {
    public func request(_ request: Request, with environment: Environment) async throws -> DataResponse<Data> {
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
