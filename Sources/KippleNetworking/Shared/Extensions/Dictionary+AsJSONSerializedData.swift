// Copyright © 2024 Brian Drelling. All rights reserved.

import Foundation

extension Dictionary {
    func asJSONSerializedData() throws -> Data {
        try JSONSerialization.data(withJSONObject: self, options: .sortedKeys)
    }
}
