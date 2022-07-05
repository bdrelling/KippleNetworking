// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

extension String {
    func trimmingSlashes() -> String {
        self.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
    }
}
