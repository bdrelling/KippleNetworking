// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

public final class UniversalNetworkRequestDispatcher {
    public let decoder: JSONDecoder

    private let dispatcher: NetworkRequestDispatching

    public init(decoder: JSONDecoder? = nil, dispatchMode: DispatchMode = .automatic) {
        self.decoder = decoder ?? .safeISO8601
        self.dispatcher = dispatchMode.configured(decoder: decoder)
    }
}

extension UniversalNetworkRequestDispatcher: NetworkRequestDispatching {
    public func request(_ request: Request, with environment: Environment) async throws -> DataResponse<Data> {
        try await self.dispatcher.request(request, with: environment)
    }

    public func requestDecoded<T>(_ request: Request, with environment: Environment) async throws -> DataResponse<T> where T: Decodable {
        try await self.dispatcher.requestDecoded(request, with: environment)
    }

    public func response<T>(for request: T, with environment: Environment) async throws -> T.Response where T: ResponseAnticipating {
        try await self.dispatcher.response(for: request, with: environment)
    }
}

extension NetworkRequestDispatching where Self == UniversalNetworkRequestDispatcher {
    public static var universal: Self {
        Self.init()
    }
}
