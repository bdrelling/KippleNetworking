// Copyright © 2022 Brian Drelling. All rights reserved.

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
