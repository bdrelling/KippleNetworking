// Copyright © 2024 Brian Drelling. All rights reserved.

import KippleNetworking

struct GetLatestXKCDStripRequest: Request, ResponseAnticipating {
    typealias Response = XKCDStrip

    var path = "/info.0.json"
}
