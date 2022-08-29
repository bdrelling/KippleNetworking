// Copyright © 2022 Brian Drelling. All rights reserved.

@testable import KippleNetworking
import XCTest

final class PrettyPrintingTests: XCTestCase {
    func testPrettyPrintSucceeds() async throws {
        let expectedOutput = """
        {
          "number" : 42,
          "string" : "Lorem ipsum"
        }
        """

        let realOutput = try Example().prettyPrinted()

        XCTAssertEqual(expectedOutput, realOutput)
    }
}

// MARK: - Supporting Types

private struct Example: Encodable {
    let number = 42
    let string = "Lorem ipsum"
}
