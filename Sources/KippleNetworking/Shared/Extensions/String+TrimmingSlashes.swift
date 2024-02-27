// Copyright © 2024 Brian Drelling. All rights reserved.

import Foundation

extension String {
    func trimmingSlashes() -> String {
        self.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
    }
}
