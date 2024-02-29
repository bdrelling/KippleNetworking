import KippleNetworking
import XCTest

final class StringExtensionTests: XCTestCase {
    /// Tests if a valid URL with a query string returns true for `isURLWithQueryString()`.
    func testValidURLWithQueryStringReturnsTrue() {
        // GIVEN
        let urlString = "https://www.example.com?key1=value1&key2=2"
        
        // WHEN
        let result = urlString.isURLWithQueryString()
        
        // THEN
        XCTAssertTrue(result)
    }
    
    /// Tests if a valid URL without a query string returns false for `isURLWithQueryString()`.
    func testValidURLWithoutQueryStringReturnsFalse() {
        // GIVEN
        let urlString = "https://www.example.com"
        
        // WHEN
        let result = urlString.isURLWithQueryString()
        
        // THEN
        XCTAssertFalse(result)
    }
    
    /// Tests if an invalid URL returns false for `isURLWithQueryString()`.
    func testInvalidURLReturnsFalse() {
        // GIVEN
        let urlString = "invalid-url"
        
        // WHEN
        let result = urlString.isURLWithQueryString()
        
        // THEN
        XCTAssertFalse(result)
    }
    
    /// Tests if a valid URL with matching parameters returns true for `isURLWithQueryString(containing:)`.
    func testValidURLWithMatchingParametersReturnsTrue() {
        // GIVEN
        let urlString = "https://www.example.com?key1=value1&key2=2"
        let parameters: [String: Any] = ["key1": "value1", "key2": 2]
        
        // WHEN
        let result = urlString.isURLWithQueryString(containing: parameters)
        
        // THEN
        XCTAssertTrue(result)
    }
    
    /// Tests if a valid URL with non-matching parameters returns false for `isURLWithQueryString(containing:)`.
    func testValidURLWithNonMatchingParametersReturnsFalse() {
        // GIVEN
        let urlString = "https://www.example.com?key1=value1&key2=2"
        let parameters: [String: Any] = ["key1": "value2", "key2": 3]
        
        // WHEN
        let result = urlString.isURLWithQueryString(containing: parameters)
        
        // THEN
        XCTAssertFalse(result)
    }
    
    /// Tests if a valid URL with a subset of parameters returns false for `isURLWithQueryString(containing:)`.
    func testValidURLWithSubsetOfParametersReturnsFalse() {
        // GIVEN
        let urlString = "https://www.example.com?key1=value1"
        let parameters: [String: Any] = ["key1": "value1", "key2": 2]
        
        // WHEN
        let result = urlString.isURLWithQueryString(containing: parameters)
        
        // THEN
        XCTAssertFalse(result)
    }
    
    /// Tests if a valid URL without parameters returns false for `isURLWithQueryString(containing:)`.
    func testValidURLWithoutParametersReturnsFalse() {
        // GIVEN
        let urlString = "https://www.example.com"
        let parameters: [String: Any] = ["key1": "value1", "key2": 2]
        
        // WHEN
        let result = urlString.isURLWithQueryString(containing: parameters)
        
        // THEN
        XCTAssertFalse(result)
    }
}
