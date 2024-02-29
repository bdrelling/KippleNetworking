#if os(iOS) || os(macOS) || os(tvOS) || os(watchOS)

@testable import KippleNetworking
import XCTest

final class URLRequestExtensionTests: XCTestCase {
    // MARK: Set Headers
    
    /// Tests setting a value for a specific HTTP header field.
    func testSetValueForHTTPHeaderField() {
        // GIVEN
        var request = URLRequest(url: URL(string: "https://www.example.com")!)
        
        // WHEN
        request.setValue(HTTPBodyEncoding.json.rawValue, forHTTPHeaderField: HTTPHeader.contentType.rawValue)
        
        // THEN
        XCTAssertEqual(request.value(forHTTPHeaderField: HTTPHeader.contentType.rawValue), HTTPBodyEncoding.json.rawValue)
    }
    
    /// Tests setting headers with a dictionary of string key-value pairs.
    func testSetHeadersWithStringDictionary() {
        // GIVEN
        
        var request = URLRequest(url: URL(string: "https://www.example.com")!)
        let headers: [String: String] = [
            HTTPHeader.contentType.rawValue: HTTPBodyEncoding.json.rawValue,
            HTTPHeader.authorization.rawValue: "Bearer token123"
        ]
        
        // WHEN
        request.setHeaders(headers)
        
        // THEN
        XCTAssertEqual(request.value(forHTTPHeaderField: HTTPHeader.contentType.rawValue), HTTPBodyEncoding.json.rawValue)
        XCTAssertEqual(request.value(forHTTPHeaderField: HTTPHeader.authorization.rawValue), "Bearer token123")
    }
    
    /// Tests setting headers with a dictionary of HTTPHeader values.
    func testSetHeadersWithHTTPHeaderDictionary() {
        // GIVEN
        var request = URLRequest(url: URL(string: "https://www.example.com")!)
        let headers: [HTTPHeader: String] = [
            .contentType: HTTPBodyEncoding.json.rawValue,
            .authorization: "Bearer token123"
        ]
        
        // WHEN
        request.setHeaders(headers)
        
        //THEN
        XCTAssertEqual(request.value(forHTTPHeaderField: HTTPHeader.contentType.rawValue), HTTPBodyEncoding.json.rawValue)
        XCTAssertEqual(request.value(forHTTPHeaderField: HTTPHeader.authorization.rawValue), "Bearer token123")
    }
    
    // MARK: Set Parameters
    
    /// Tests setting parameters with JSON encoding.
    func testSetParametersWithJSONEncoding() {
        // GIVEN a URLRequest object and parameters
        var request = URLRequest(url: URL(string: "https://www.example.com")!)
        let parameters: [String: Any] = ["key1": "value1", "key2": 2]
        
        // WHEN setting parameters with JSON encoding
        try? request.setParameters(parameters, encoding: .httpBody(.json))
        
        // THEN the Content-Type header should be set to JSON
        XCTAssertEqual(request.value(forHTTPHeaderField: HTTPHeader.contentType.rawValue), HTTPBodyEncoding.json.rawValue)
        
        // AND the HTTP body should be non-nil
        XCTAssertNotNil(request.httpBody)
        
        // AND there should be no query string
        XCTAssertEqual(request.url?.absoluteString, "https://www.example.com")
        XCTAssertNil(request.url?.query())
    }

    /// Tests setting parameters with URL-encoded form encoding.
    func testSetParametersWithURLEncodedFormEncoding() throws {
        // GIVEN a URLRequest object and parameters
        var request = URLRequest(url: URL(string: "https://www.example.com")!)
        let parameters: [String: Any] = ["key1": "value1", "key2": 2]
        
        // WHEN setting parameters with URL-encoded form encoding
        try? request.setParameters(parameters, encoding: .httpBody(.wwwFormURLEncoded))
        
        // THEN the Content-Type header should be set to URL-encoded form
        XCTAssertEqual(request.value(forHTTPHeaderField: HTTPHeader.contentType.rawValue), HTTPBodyEncoding.wwwFormURLEncoded.rawValue)
        
        // AND the HTTP body should be non-nil
        XCTAssertNotNil(request.httpBody)
        
        // AND there should be no query string
        XCTAssertEqual(request.url?.absoluteString, "https://www.example.com")
        XCTAssertNil(request.url?.query())
    }

    /// Tests setting parameters with query string encoding.
    func testSetParametersWithQueryStringEncoding() throws {
        // GIVEN a URLRequest object and parameters
        var request = URLRequest(url: URL(string: "https://www.example.com")!)
        let parameters: [String: Any] = ["key1": "value1", "key2": 2]
        
        // WHEN setting parameters with query string encoding
        try? request.setParameters(parameters, encoding: .queryString)
        
        // THEN the URL should include the parameters in the query string
        let url = try XCTUnwrap(request.url?.absoluteString)
        XCTAssertTrue(url.isURLWithQueryString(containing: parameters))
        
        // AND the HTTP body should be nil
        XCTAssertNil(request.httpBody)
    }

    /// Tests setting parameters with JSON encoding using an Encodable object.
    func testSetParametersWithEncodableAndJSONEncoding() {
        // GIVEN a URLRequest object and an Encodable object
        struct Model: Encodable {
            let key1: String
            let key2: Int
        }
        var request = URLRequest(url: URL(string: "https://www.example.com")!)
        let model = Model(key1: "value1", key2: 2)
        
        // WHEN setting parameters with JSON encoding using an Encodable object
        try? request.setParameters(model, encoding: .httpBody(.json))
        
        // THEN the Content-Type header should be set to JSON
        XCTAssertEqual(request.value(forHTTPHeaderField: HTTPHeader.contentType.rawValue), HTTPBodyEncoding.json.rawValue)
        
        // AND the HTTP body should be non-nil
        XCTAssertNotNil(request.httpBody)
        
        // AND there should be no query string
        XCTAssertEqual(request.url?.absoluteString, "https://www.example.com")
        XCTAssertNil(request.url?.query())
    }

    /// Tests setting parameters with URL-encoded form encoding using an Encodable object.
    func testSetParametersWithEncodableAndURLEncodedFormEncoding() throws {
        // GIVEN a URLRequest object and an Encodable object
        struct Model: Encodable {
            let key1: String
            let key2: Int
        }
        var request = URLRequest(url: URL(string: "https://www.example.com")!)
        let model = Model(key1: "value1", key2: 2)
        
        // WHEN setting parameters with URL-encoded form encoding using an Encodable object
        try? request.setParameters(model, encoding: .httpBody(.wwwFormURLEncoded))
        
        // THEN the Content-Type header should be set to URL-encoded form
        XCTAssertEqual(request.value(forHTTPHeaderField: HTTPHeader.contentType.rawValue), HTTPBodyEncoding.wwwFormURLEncoded.rawValue)
        
        // AND the HTTP body should be non-nil
        XCTAssertNotNil(request.httpBody)
        
        // AND there should be no query string
        XCTAssertEqual(request.url?.absoluteString, "https://www.example.com")
        XCTAssertNil(request.url?.query())
    }

    
    // MARK: Set Timeout
    
    /// Tests setting a timeout interval for a `URLRequest`.
    func testSetTimeout() {
        // GIVEN
        var request = URLRequest(url: URL(string: "https://www.example.com")!)
        
        // WHEN
        request.setTimeout(42)
        
        // THEN
        XCTAssertEqual(request.timeoutInterval, 42)
    }
    
    /// Tests setting the timeout interval to the default value when nil is provided.
    func testSetTimeoutWithNil() {
        // GIVEN
        var request = URLRequest(url: URL(string: "https://www.example.com")!)
        
        // WHEN
        request.setTimeout(nil)
        
        // THEN
        XCTAssertEqual(request.timeoutInterval, URLRequest.defaultTimeoutInterval)
    }
    
    // MARK: - withTimeout Tests
    
    /// Tests creating a copy of a URLRequest with a timeout interval.
    func testWithTimeout() {
        // GIVEN
        let originalRequest = URLRequest(url: URL(string: "https://www.example.com")!)
        
        // WHEN
        let requestWithTimeout = originalRequest.withTimeout(42)
        
        // THEN
        XCTAssertEqual(requestWithTimeout.timeoutInterval, 42)
    }
    
    /// Tests creating a copy of a URLRequest with the default timeout interval when nil is provided.
    func testWithTimeoutWithNil() {
        // GIVEN
        let originalRequest = URLRequest(url: URL(string: "https://www.example.com")!)
        
        // WHEN
        let requestWithTimeout = originalRequest.withTimeout(nil)
        
        // THEN
        XCTAssertEqual(requestWithTimeout.timeoutInterval, URLRequest.defaultTimeoutInterval)
    }
}
#endif
