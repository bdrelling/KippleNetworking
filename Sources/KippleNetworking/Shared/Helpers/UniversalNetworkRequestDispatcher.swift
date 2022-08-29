// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation
import Logging

public final class UniversalNetworkRequestDispatcher {
    public let decoder: JSONDecoder

    private let dispatcher: NetworkRequestDispatching

    public init(decoder: JSONDecoder? = nil, dispatchMode: DispatchMode = .automatic) {
        self.decoder = decoder ?? .safeISO8601
        self.dispatcher = dispatchMode.configured(decoder: decoder)
    }
}

// MARK: - Extensions

extension UniversalNetworkRequestDispatcher: NetworkRequestDispatching {
    public func request(_ request: Request, with environment: Environment, logger: Logger? = nil) async throws -> DataResponse<Data> {
        try await self.dispatcher.request(request, with: environment, logger: logger)
    }

    public func requestDecoded<T>(_ request: Request, with environment: Environment, logger: Logger? = nil) async throws -> DataResponse<T> where T: Decodable {
        try await self.dispatcher.requestDecoded(request, with: environment, logger: logger)
    }

    public func response<T>(for request: T, with environment: Environment, logger: Logger? = nil) async throws -> T.Response where T: ResponseAnticipating {
        try await self.dispatcher.response(for: request, with: environment, logger: logger)
    }
}

// MARK: - Convenience

public extension NetworkRequestDispatching where Self == UniversalNetworkRequestDispatcher {
    static var universal: Self {
        .init()
    }

    static func universal(decoder: JSONDecoder? = nil) -> Self {
        .init(decoder: decoder)
    }
}
