// Copyright © 2022 Brian Drelling. All rights reserved.

import KippleNetworking

// TODO: Use Xkcd service? https://github.com/swift-server/async-http-client/blob/main/Examples/GetJSON/GetJSON.swift
public struct GetXkcdStripRequest: Request, ResponseAnticipating {
    public typealias Response = XkcdStrip

    private enum Parameters: String {
        case id
    }

    public var path: String {
        "/\(self.id)/info.0.json"
    }

    public private(set) var parameters: [String: Any] = [:]

    private let id: Int

    public init(id: Int) {
        self.id = id
    }
}
