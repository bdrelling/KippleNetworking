// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation
import UtilityBeltNetworking

public protocol Request {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any] { get }
    var headers: [String: String] { get }
    var encoding: ParameterEncoding { get }
}

public extension Request {
    var method: HTTPMethod {
        .get
    }

    var parameters: [String: Any] {
        [:]
    }

    var headers: [String: String] {
        [:]
    }

    var encoding: ParameterEncoding {
        .defaultEncoding(for: self.method)
    }
}

// MARK: - Supporting Types

public final class DecodableRequest<T: Decodable>: Request, ResponseAnticipating {
    public typealias Response = T

    public var path: String

    public init(_ path: String) {
        self.path = path
    }

    public init(_ path: String, response: T.Type) {
        self.path = path
    }
}

public protocol ResponseAnticipating: Request {
    associatedtype Response: Decodable
}
