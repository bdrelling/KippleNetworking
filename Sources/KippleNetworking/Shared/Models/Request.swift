// Copyright © 2024 Brian Drelling. All rights reserved.

import Foundation

public protocol Request {
    var baseURL: String? { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any] { get }
    var body: Data? { get }
    var headers: [String: String] { get }
    var encoding: ParameterEncoding { get }
    var rootResponseKey: String? { get }

    func validate() throws
}

public extension Request {
    var baseURL: String? {
        nil
    }

    var method: HTTPMethod {
        .get
    }

    var parameters: [String: Any] {
        [:]
    }

    var body: Data? {
        nil
    }

    var headers: [String: String] {
        [:]
    }

    var encoding: ParameterEncoding {
        .defaultEncoding(for: self.method)
    }

    var rootResponseKey: String? {
        nil
    }

    func validate() throws {}
}

// MARK: - Supporting Types

public struct HTTPRequest: Request {
    public let baseURL: String?
    public let path: String
    public let method: HTTPMethod
    public let parameters: [String: Any]
    public let body: Data?
    public let headers: [String: String]
    public let encoding: ParameterEncoding

    public init(
        path: String,
        baseURL: String? = nil,
        method: HTTPMethod = .get,
        parameters: [String: Any] = [:],
        body: Data? = nil,
        headers: [String: String] = [:],
        encoding: ParameterEncoding? = nil
    ) {
        self.path = path
        self.baseURL = baseURL
        self.method = method
        self.parameters = parameters
        self.body = body
        self.headers = headers
        self.encoding = encoding ?? .defaultEncoding(for: method)
    }
}

/// A convenience request that decodes the response of a GET request with no parameters or headers.
public struct DecodableRequest<T: Decodable>: Request, ResponseAnticipating {
    public typealias Response = T

    public let path: String

    public init(_ path: String, response: T.Type) {
        self.path = path
    }
}

public protocol ResponseAnticipating: Request {
    associatedtype Response: Decodable
}

// MARK: - Convenience

public extension HTTPRequest {
    init(
        url: String,
        method: HTTPMethod = .get,
        parameters: [String: Any] = [:],
        body: Data? = nil,
        headers: [String: String] = [:],
        encoding: ParameterEncoding? = nil
    ) {
        self.init(path: "", baseURL: url, method: method, parameters: parameters, body: body, headers: headers, encoding: encoding)
    }
}
