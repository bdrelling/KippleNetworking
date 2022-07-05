// Copyright © 2022 Brian Drelling. All rights reserved.

import KippleNetworking

// TODO: Use Xkcd service? https://github.com/swift-server/async-http-client/blob/main/Examples/GetJSON/GetJSON.swift
public struct GetPostsRequest: Request, ResponseAnticipating {
    private enum Parameters: String {
        case id
    }

    public var path: String {
        "/posts/\(self.id)"
    }

    public private(set) var parameters: [String: Any] = [:]

    private let id: Int

    public init(id: Int) {
        self.parameters[Parameters.id.rawValue] = id
        self.id = id
    }

    public struct Response: Decodable {
        public let userId: Int
        public let id: Int
        public let title: String
        public let body: String
    }
}
