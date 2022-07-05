// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

extension JSONEncoder {
    static let safeISO8601: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .safeISO8601
        return encoder
    }()
}

extension JSONEncoder.DateEncodingStrategy {
    static let safeISO8601 = custom {
        var container = $1.singleValueContainer()
        try container.encode(Formatter.iso8601withFractionalSeconds.string(from: $0))
    }
}
