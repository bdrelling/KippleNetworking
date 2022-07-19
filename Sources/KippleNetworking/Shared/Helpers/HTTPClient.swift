// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

public final class HTTPClient {
    private let environment: Environment
    private let dispatcher: NetworkRequestDispatching

    public init(environment: Environment, dispatcher: NetworkRequestDispatching = .universal) {
        self.environment = environment
        self.dispatcher = dispatcher
    }
    
    public func request(_ request: Request, with environment: Environment? = nil) async throws -> DataResponse<Data> {
        try await self.dispatcher.request(request, with: environment ?? self.environment)
    }

    public func requestDecoded<T>(_ request: Request, with environment: Environment? = nil) async throws -> DataResponse<T> where T: Decodable {
        try await self.dispatcher.requestDecoded(request, with: environment ?? self.environment)
    }

    public func response<T>(for request: T, with environment: Environment? = nil) async throws -> T.Response where T: ResponseAnticipating {
        try await self.dispatcher.response(for: request, with: environment ?? self.environment)
    }
}
