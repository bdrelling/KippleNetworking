// Copyright © 2024 Brian Drelling. All rights reserved.

import Foundation

public struct Environment {
    private static let urlTrimmedCharacterSet = CharacterSet(charactersIn: "/").union(.whitespacesAndNewlines)

    public let baseURL: String
    public let headers: [String: String]
    public let parameters: [String: Any]
    public let timeout: Int?
    public let rootResponseKey: String?

    public init(
        baseURL: String,
        headers: [String: String] = [:],
        parameters: [String: Any] = [:],
        timeout: Int? = nil,
        rootResponseKey: String? = nil
    ) {
        self.baseURL = baseURL.trimmingCharacters(in: Self.urlTrimmedCharacterSet)
        self.headers = headers
        self.parameters = parameters
        self.timeout = timeout
        self.rootResponseKey = rootResponseKey
    }

    public init(
        baseURL: String,
        headers: [HTTPHeader: String],
        parameters: [String: Any] = [:],
        timeout: Int? = nil,
        rootResponseKey: String? = nil
    ) {
        self.init(
            baseURL: baseURL,
            headers: headers.asHeaderDictionary(),
            parameters: parameters,
            timeout: timeout,
            rootResponseKey: rootResponseKey
        )
    }
}

// MARK: - Extensions

extension Environment: Equatable {
    public static func == (lhs: Environment, rhs: Environment) -> Bool {
        lhs.baseURL == rhs.baseURL
            && lhs.headers == rhs.headers
            && lhs.timeout == rhs.timeout
            && lhs.rootResponseKey == rhs.rootResponseKey
            // source: https://stackoverflow.com/questions/32365654/how-do-i-compare-two-dictionaries-in-swift
            && NSDictionary(dictionary: lhs.parameters).isEqual(to: rhs.parameters)
    }
}
