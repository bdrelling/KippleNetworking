// Copyright © 2022 Brian Drelling. All rights reserved.

import KippleNetworking

public struct GetLatestXkcdStripRequest: Request, ResponseAnticipating {
    public typealias Response = XkcdStrip

    public var path: String {
        "/info.0.json"
    }

    public private(set) var parameters: [String: Any] = [:]

    public init() {}
}
