// Copyright © 2022 Brian Drelling. All rights reserved.

// public class NetworkRequestDispatcher {
//    private let client: NetworkingClient
//    private let environment: Environment
//    private let decoder: JSONDecoder = .safeISO8601
//
//    public init(environment: Environment) {
//        self.environment = environment
//        self.client = Self.configuredClient()
//    }
//
//    public convenience init(baseURL: String) {
//        self.init(environment: .init(baseURL: baseURL))
//    }
//
