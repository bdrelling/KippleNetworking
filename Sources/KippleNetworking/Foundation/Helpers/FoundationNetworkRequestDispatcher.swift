// Copyright © 2022 Brian Drelling. All rights reserved.

#if os(iOS) || os(macOS) || os(tvOS) || os(watchOS)

    import Foundation

    public final class FoundationNetworkRequestDispatcher {
        public let environment: Environment
        public let decoder: JSONDecoder

        private let session: URLSession

        public init(environment: Environment, decoder: JSONDecoder? = nil, session: URLSession = .shared) {
            self.environment = environment
            self.decoder = decoder ?? .safeISO8601
            self.session = session
        }

        public convenience init(baseURL: String, decoder: JSONDecoder? = nil, session: URLSession = .shared) {
            self.init(environment: .init(baseURL: baseURL), decoder: decoder, session: session)
        }
    }

    // MARK: - Extensions

    private extension FoundationNetworkRequestDispatcher {
        func request(_ urlRequest: URLRequest) async throws -> (Data, URLResponse) {
            return try await self.session.data(for: urlRequest)
        }
    }

    extension FoundationNetworkRequestDispatcher: NetworkRequestDispatching {
        public func request(_ request: Request) async throws -> DataResponse<Data> {
            let urlRequest = try request.asURLRequest(with: self.environment)
            let (data, response) = try await self.request(urlRequest)

            return try .init(request: request, response: response, data: data)
        }
    }

#endif
