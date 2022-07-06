// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

public typealias HTTPClient = UniversalNetworkRequestDispatcher

public final class UniversalNetworkRequestDispatcher {
    public let environment: Environment
    public let decoder: JSONDecoder

    private let dispatcher: NetworkRequestDispatching

    public init(environment: Environment, decoder: JSONDecoder? = nil, dispatchMode: DispatchMode = .automatic) {
        self.environment = environment
        self.decoder = decoder ?? .safeISO8601
        self.dispatcher = dispatchMode.configured(for: environment, decoder: decoder)
    }

    public convenience init(baseURL: String, decoder: JSONDecoder? = nil, dispatchMode: DispatchMode = .automatic) {
        self.init(environment: .init(baseURL: baseURL), decoder: decoder, dispatchMode: dispatchMode)
    }
}

extension UniversalNetworkRequestDispatcher: NetworkRequestDispatching {
    public func request(for request: Request) async throws -> DataResponse<Data> {
        try await self.dispatcher.request(request)
    }

    public func request<T>(for request: Request) async throws -> DataResponse<T> where T: Decodable {
        try await self.dispatcher.request(request)
    }

    public func request<T>(for request: T) async throws -> DataResponse<T.Response> where T: ResponseAnticipating {
        try await self.dispatcher.request(request)
    }
}
