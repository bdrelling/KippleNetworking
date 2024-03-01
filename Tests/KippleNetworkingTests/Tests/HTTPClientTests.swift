@testable import KippleNetworking
import XCTest

final class HTTPClientTests: XCTestCase {
    // MARK: Properties
    
    /// The ID of the XKCD strip we're testing.
    private let stripID = 123
    
    // MARK: Requests
    
    /// Tests making a request with a given request object.
    func testRequest() async throws {
        // GIVEN
        let httpClient = HTTPClient(environment: .xkcd)
        let request = GetXKCDStripRequest(id: self.stripID)
        
        // WHEN
        let response = try await httpClient.request(request)
        let decodedStrip = try httpClient.dispatcher.decoder.decode(XKCDStrip.self, from: response.data)
        
        // THEN
        XCTAssertNotNil(response)
        XCTAssertEqual(response.status, .ok)
        XCTAssertEqual(decodedStrip, .centrifugalForce)
    }
    
    /// Tests making a decoded request with a given request object.
    func testRequestDecoded() async throws {
        // GIVEN
        let httpClient = HTTPClient(environment: .xkcd)
        let request = GetXKCDStripRequest(id: self.stripID)
        
        // WHEN
        let response: DataResponse<XKCDStrip> = try await httpClient.requestDecoded(request)
        let decodedStrip = try httpClient.dispatcher.decoder.decode(XKCDStrip.self, from: response.data)
        
        // THEN
        XCTAssertNotNil(response)
        XCTAssertEqual(response.status, .ok)
        XCTAssertEqual(decodedStrip, .centrifugalForce)
    }
    
    /// Tests getting a response for a given request object.
    func testResponse() async throws {
        // GIVEN
        let client = HTTPClient(environment: .xkcd)
        let request = GetXKCDStripRequest(id: self.stripID)
        
        // WHEN
        let response: XKCDStrip = try await client.response(for: request)
        
        // THEN
        XCTAssertEqual(response.num, 123)
        XCTAssertEqual(response, .centrifugalForce)
    }
    
    // MARK: URL Strings
    
    /// Tests making a request with a given URL.
    func testRequestWithURL() async throws {
        // GIVEN
        let httpClient = HTTPClient(environment: .xkcd)
        let url = GetXKCDStripRequest(id: self.stripID).urlString(with: .xkcd)
        
        // WHEN
        let response: DataResponse<XKCDStrip> = try await httpClient.request(url: url)
        let decodedStrip = try httpClient.dispatcher.decoder.decode(XKCDStrip.self, from: response.data)
        
        // THEN
        XCTAssertEqual(response.status, .ok)
        XCTAssertNotNil(response.data)
        
        XCTAssertEqual(decodedStrip, .centrifugalForce)
    }
    
    /// Tests making a decoded request with a given URL.
    func testRequestDecodedWithURL() async throws {
        // GIVEN
        let httpClient = HTTPClient(environment: .xkcd)
        let url = GetXKCDStripRequest(id: self.stripID).urlString(with: .xkcd)
        
        // WHEN
        let response = try await httpClient.request(url: url)
        let decodedStrip = try httpClient.dispatcher.decoder.decode(XKCDStrip.self, from: response.data)
        
        // THEN
        XCTAssertEqual(response.status, .ok)
        XCTAssertNotNil(response.data)

        XCTAssertEqual(decodedStrip, .centrifugalForce)
    }
}

// MARK: - Supporting Types

private extension XKCDStrip {
    static let centrifugalForce: Self = .init(
        month: "7", num: 123,
        link: "",
        year: "2006",
        news: "",
        safe_title: "Centrifugal Force",
        transcript: "[[ Bond is tied to a giant centrifuge ]]\nHat Guy: Do you like my centrifuge, Mister Bond? When I throw the lever, you will feel centrifugal force crush every bone in your body.\nMr. Bond: You mean centripetal force. There\'s no such thing as centrifugal force.\nHat Guy: A laughable claim, Mister Bond, perpetuated by overzealous teachers of science. Simply construct Newton\'s laws into a rotating system and you will see a centrifugal force term appear as plain as day.\nMr. Bond: Come now, do you really expect me to do coordinate substitution in my head while strapped to a centrifuge?\nHat Guy: No, Mr. Bond. I expect you to die.\n{{ alt: You spin me right round, baby, right round, in a manner depriving me of an inertial reference frame.  Baby. }}",
        alt: "You spin me right round, baby, right round, in a manner depriving me of an inertial reference frame.  Baby.",
        img: "https://imgs.xkcd.com/comics/centrifugal_force.png",
        title: "Centrifugal Force",
        day: "3"
    )
}
