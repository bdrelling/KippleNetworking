@testable import KippleNetworking
import XCTest

final class RFC3986ExtensionTests: XCTestCase {
    // MARK: CharacterSet Extensions
    
    func testRFC3986UnreservedCharacterSet() {
        let unreservedCharacters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~"
        let rfc3986CharacterSet = CharacterSet.rfc3986Unreserved
        for scalar in unreservedCharacters.unicodeScalars {
            XCTAssertTrue(rfc3986CharacterSet.contains(scalar), "Character \(scalar) should be in RFC3986 unreserved character set.")
        }
    }
}
