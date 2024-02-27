// Copyright © 2024 Brian Drelling. All rights reserved.

import KippleNetworking

struct GetLatestXkcdStripRequest: Request, ResponseAnticipating {
    typealias Response = XkcdStrip

    var path = "/info.0.json"
}
