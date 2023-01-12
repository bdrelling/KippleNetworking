// Copyright © 2023 Brian Drelling. All rights reserved.

public extension String {
    func base64Encoded() -> String? {
        let data = self.data(using: .utf8)
        return data?.base64EncodedString()
    }
}
