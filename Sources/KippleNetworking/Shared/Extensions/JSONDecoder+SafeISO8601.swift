// Copyright © 2024 Brian Drelling. All rights reserved.

import Foundation

public extension JSONDecoder {
    static let safeISO8601: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .safeISO8601
        return decoder
    }()
}

extension JSONDecoder.DateDecodingStrategy {
    static let safeISO8601 = custom {
        let container = try $0.singleValueContainer()
        let string = try container.decode(String.self)
        if let date = Formatter.iso8601withFractionalSeconds.date(from: string) ?? Formatter.iso8601.date(from: string) {
            return date
        }
        throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date: \(string)")
    }
}
