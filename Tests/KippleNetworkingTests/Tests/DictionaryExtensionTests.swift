import KippleNetworking
import XCTest

final class DictionaryExtensionTests: XCTestCase {
    func testAsHeaderDictionary() {
        let headers: [HTTPHeader: String] = [
            .contentType: "application/json",
            .authorization: "Bearer token123",
            .accept: "application/json"
        ]
        
        let headerDictionary = headers.asHeaderDictionary()
        
        XCTAssertEqual(headerDictionary.count, 3)
        XCTAssertEqual(headerDictionary["Content-Type"], "application/json")
        XCTAssertEqual(headerDictionary["Authorization"], "Bearer token123")
        XCTAssertEqual(headerDictionary["Accept"], "application/json")
    }
}
