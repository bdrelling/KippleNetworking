// Copyright © 2024 Brian Drelling. All rights reserved.

import KippleNetworking

// TODO: Use Xkcd service? https://github.com/swift-server/async-http-client/blob/main/Examples/GetJSON/GetJSON.swift
struct GetXkcdStripRequest: Request, ResponseAnticipating {
    typealias Response = XkcdStrip

    var path: String {
        "/\(self.id)/info.0.json"
    }

    private let id: Int

    public init(id: Int) {
        self.id = id
    }
}
