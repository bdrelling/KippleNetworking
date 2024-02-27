// Copyright © 2024 Brian Drelling. All rights reserved.

#if os(iOS) || os(macOS) || os(tvOS) || os(watchOS)

@testable import KippleNetworking
import XCTest

final class FoundationNetworkRequestDispatcherTests: XCTestCase {
    func testRequestSucceeds() async throws {
        let environment = Environment(baseURL: "https://xkcd.com")
        let dispatcher = FoundationNetworkRequestDispatcher()
        let request = GetXkcdStripRequest(id: XkcdStrip.exploitsOfAMom.num)

        let response: XkcdStrip = try await dispatcher.response(for: request, with: environment)

        XCTAssertEqual(response, .exploitsOfAMom)
    }
}

#endif
