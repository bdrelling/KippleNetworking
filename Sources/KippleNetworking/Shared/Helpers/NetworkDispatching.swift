// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

public protocol NetworkRequestDispatching {
    associatedtype HTTPClient

    var client: HTTPClient { get }
    var environment: Environment { get }
    var decoder: JSONDecoder { get }

    init(environment: Environment)

    func request<T: ResponseAnticipating>(_ request: T) async throws -> T.Response

    static func configuredClient() -> HTTPClient
}

// MARK: - Extensions

public extension NetworkRequestDispatching {
    init(baseURL: String) {
        self.init(environment: .init(baseURL: baseURL))
    }
}
