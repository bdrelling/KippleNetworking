// Copyright © 2024 Brian Drelling. All rights reserved.

import KippleNetworking

struct GetXKCDStripRequest: Request, ResponseAnticipating {
    typealias Response = XKCDStrip

    var path: String {
        "/\(self.id)/info.0.json"
    }

    private let id: Int

    public init(id: Int) {
        self.id = id
    }
}
