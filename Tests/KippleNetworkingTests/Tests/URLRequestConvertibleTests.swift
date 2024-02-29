#if os(iOS) || os(macOS) || os(tvOS) || os(watchOS)

import KippleNetworking
import XCTest

final class URLRequestConvertibleTests: XCTestCase {
    func testURLRequestConvertibleURLRequest() {
        let url = URL(string: "https://www.example.com")!
        let urlRequest = try? url.asURLRequest()
        XCTAssertNotNil(urlRequest)
        XCTAssertEqual(urlRequest?.url, url)
    }
    
    func testURLRequestConvertibleString() {
        let urlString = "https://www.example.com"
        let urlRequest = try? urlString.asURLRequest()
        XCTAssertNotNil(urlRequest)
        XCTAssertEqual(urlRequest?.url?.absoluteString, urlString)
    }
    
    func testURLRequestConvertibleStringWithQueryParams() {
        let urlString = "https://www.example.com/path?param1=value1&param2=value2"
        let urlRequest = try? urlString.asURLRequest()
        XCTAssertNotNil(urlRequest)
        XCTAssertEqual(urlRequest?.url?.absoluteString, "https://www.example.com/path?param1=value1&param2=value2")
        XCTAssertEqual(urlRequest?.url?.query, "param1=value1&param2=value2")
    }
}
#endif
