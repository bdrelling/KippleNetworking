// Copyright © 2024 Brian Drelling. All rights reserved.

import Foundation
import Logging

public final class HTTPClient {
    public var environment: Environment
    public let dispatcher: NetworkRequestDispatching
    public let logger: Logger?

    public init(environment: Environment, dispatcher: NetworkRequestDispatching = .universal, logger: Logger? = nil) {
        self.environment = environment
        self.dispatcher = dispatcher
        self.logger = logger
    }

    public func request(_ request: Request, with environment: Environment? = nil) async throws -> DataResponse<Data> {
        try await self.dispatcher.request(request, with: environment ?? self.environment, logger: self.logger)
    }

    public func requestDecoded<T>(_ request: Request, with environment: Environment? = nil) async throws -> DataResponse<T> where T: Decodable {
        try await self.dispatcher.requestDecoded(request, with: environment ?? self.environment, logger: self.logger)
    }

    public func response<T>(for request: T, with environment: Environment? = nil) async throws -> T.Response where T: ResponseAnticipating {
        try await self.dispatcher.response(for: request, with: environment ?? self.environment, logger: self.logger)
    }
}

// MARK: - Convenience

public extension HTTPClient {
    func request(
        url: String,
        method: HTTPMethod = .get,
        parameters: [String: Any] = [:],
        headers: [String: String] = [:],
        encoding: ParameterEncoding? = nil,
        with environment: Environment? = nil
    ) async throws -> DataResponse<Data> {
        let request = HTTPRequest(
            url: url,
            method: method,
            parameters: parameters,
            headers: headers,
            encoding: encoding
        )

        return try await self.request(request, with: environment)
    }

    func request<T>(
        url: String,
        method: HTTPMethod = .get,
        parameters: [String: Any] = [:],
        headers: [String: String] = [:],
        encoding: ParameterEncoding? = nil,
        with environment: Environment? = nil
    ) async throws -> DataResponse<T> where T: Decodable {
        let request = HTTPRequest(
            url: url,
            method: method,
            parameters: parameters,
            headers: headers,
            encoding: encoding
        )

        return try await self.requestDecoded(request, with: environment)
    }
}
