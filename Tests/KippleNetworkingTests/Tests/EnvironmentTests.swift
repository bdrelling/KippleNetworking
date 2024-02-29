import KippleNetworking
import XCTest

final class EnvironmentTests: XCTestCase {
    // MARK: Initialization
    
    /// Tests initializing an Environment with only a baseURL.
    func testInitWithBaseURL() {
        // GIVEN
        let baseURL = "https://www.example.com"
        
        // WHEN
        let environment = Environment(baseURL: baseURL)
        
        // THEN
        XCTAssertEqual(environment.baseURL, baseURL)
        XCTAssertTrue(environment.headers.isEmpty)
        XCTAssertTrue(environment.parameters.isEmpty)
        XCTAssertNil(environment.timeout)
        XCTAssertNil(environment.rootResponseKey)
    }
    
    /// Tests initializing an Environment with all parameters provided.
    func testInitWithAllParameters() {
        // GIVEN
        let baseURL = "https://www.example.com"
        let headers = ["Authorization": "Bearer token"]
        let parameters: [String: String] = ["key": "value"]
        let timeout: Int? = 30
        let rootResponseKey = "data"
        
        // WHEN
        let environment = Environment(
            baseURL: baseURL,
            headers: headers,
            parameters: parameters,
            timeout: timeout,
            rootResponseKey: rootResponseKey
        )
        
        // THEN
        XCTAssertEqual(environment.baseURL, baseURL)
        XCTAssertEqual(environment.headers, headers)
        XCTAssertEqual(environment.parameters as? [String: String], parameters)
        XCTAssertEqual(environment.timeout, timeout)
        XCTAssertEqual(environment.rootResponseKey, rootResponseKey)
    }
    
    /// Tests initializing an Environment with default values for optional parameters.
    func testInitWithDefaultValues() {
        // GIVEN
        let baseURL = "https://www.example.com"
        
        // WHEN
        let environment = Environment(baseURL: baseURL)
        
        // THEN
        XCTAssertEqual(environment.baseURL, baseURL)
        XCTAssertTrue(environment.headers.isEmpty)
        XCTAssertTrue(environment.parameters.isEmpty)
        XCTAssertNil(environment.timeout)
        XCTAssertNil(environment.rootResponseKey)
    }
    
    // MARK: Equatability
    
    /// Tests the equality of two identical Environment instances.
    func testEquality() {
        // GIVEN
        let baseURL = "https://www.example.com"
        let headers = ["Authorization": "Bearer token"]
        let parameters = ["key": "value"]
        let timeout: Int? = 30
        let rootResponseKey = "data"
        
        let environment1 = Environment(
            baseURL: baseURL,
            headers: headers,
            parameters: parameters,
            timeout: timeout,
            rootResponseKey: rootResponseKey
        )
        let environment2 = Environment(
            baseURL: baseURL,
            headers: headers,
            parameters: parameters,
            timeout: timeout,
            rootResponseKey: rootResponseKey
        )
        
        // THEN
        XCTAssertEqual(environment1, environment2)
    }
    
    /// Tests the inequality of two different Environment instances.
    func testInequality() {
        // GIVEN
        let baseURL1 = "https://www.example1.com"
        let baseURL2 = "https://www.example2.com"
        let headers1 = ["Authorization": "Bearer token"]
        let headers2 = ["Authorization": "Bearer differentToken"]
        let parameters1 = ["key": "value"]
        let parameters2 = ["differentKey": "differentValue"]
        let timeout1: Int? = 30
        let timeout2: Int? = 60
        let rootResponseKey1 = "data"
        let rootResponseKey2 = "differentData"
        
        let environment1 = Environment(
            baseURL: baseURL1,
            headers: headers1,
            parameters: parameters1,
            timeout: timeout1,
            rootResponseKey: rootResponseKey1
        )
        let environment2 = Environment(
            baseURL: baseURL2,
            headers: headers2,
            parameters: parameters2,
            timeout: timeout2,
            rootResponseKey: rootResponseKey2
        )
        
        // THEN
        XCTAssertNotEqual(environment1, environment2)
    }
}
