// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

public extension Dictionary where Key == HTTPHeader, Value == String {
    func asHeaderDictionary() -> [String: String] {
        var headers: [String: String] = [:]

        for element in self {
            headers[element.key.rawValue] = element.value
        }

        return headers
    }
}
