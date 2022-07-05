// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

/// Environment is a struct which encapsulate all the informations
/// we need to perform a setup of our Networking Layer.
/// In this example we just define the name of the environment (ie. Production,
/// Test Environment #1 and so on) and the base url to complete requests.
/// You may also want to include any SSL certificate or wethever you need.
public struct Environment {
    private static let urlTrimmedCharacterSet = CharacterSet(charactersIn: "/").union(.whitespacesAndNewlines)

    public let baseURL: String
    public let headers: [String: String]
    public let parameters: [String: Any]
    public let rootResponseKey: String?

    public init(
        baseURL: String,
        headers: [String: String] = [:],
        parameters: [String: Any] = [:],
        rootResponseKey: String? = nil
    ) {
        self.baseURL = baseURL.trimmingCharacters(in: Self.urlTrimmedCharacterSet)
        self.headers = headers
        self.parameters = parameters
        self.rootResponseKey = rootResponseKey
    }
}
