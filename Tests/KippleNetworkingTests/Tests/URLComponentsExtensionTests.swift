@testable import KippleNetworking
import XCTest

final class URLComponentsExtensionTests: XCTestCase {
    func testSetQueryItems() {
        // GIVEN
        var components = URLComponents()
        let parameters: [String: Any] = [
            "name": "John Doe",
            "age": 30,
            "isStudent": true,
            "grades": [85, 90, 95],
            "address": [
                "street": "123 Main St",
                "city": "Anytown"
            ]
        ]
        
        // WHEN
        components.setQueryItems(with: parameters)
        
        // THEN
        XCTAssertEqual(components.queryItems?.count, 8)
        XCTAssertTrue(components.queryItems?.contains(URLQueryItem(name: "name", value: "John Doe")) ?? false)
        XCTAssertTrue(components.queryItems?.contains(URLQueryItem(name: "age", value: "30")) ?? false)
        XCTAssertTrue(components.queryItems?.contains(URLQueryItem(name: "isStudent", value: "true")) ?? false)
        XCTAssertTrue(components.queryItems?.contains(URLQueryItem(name: "grades[]", value: "85")) ?? false)
        XCTAssertTrue(components.queryItems?.contains(URLQueryItem(name: "grades[]", value: "90")) ?? false)
        XCTAssertTrue(components.queryItems?.contains(URLQueryItem(name: "grades[]", value: "95")) ?? false)
        XCTAssertTrue(components.queryItems?.contains(URLQueryItem(name: "address[street]", value: "123 Main St")) ?? false)
        XCTAssertTrue(components.queryItems?.contains(URLQueryItem(name: "address[city]", value: "Anytown")) ?? false)
    }
}
