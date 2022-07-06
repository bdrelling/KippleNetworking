// Copyright © 2022 Brian Drelling. All rights reserved.

#if os(iOS) || os(macOS) || os(tvOS) || os(watchOS)

    @testable import KippleNetworking
    import XCTest

    final class FoundationNetworkRequestDispatcherTests: XCTestCase {
        func testRequestSucceeds() async throws {
            let networkDispatcher = FoundationNetworkRequestDispatcher(baseURL: "https://xkcd.com")
            let request = GetXkcdStripRequest(id: XkcdStrip.exploitsOfAMom.num)
            let response: XkcdStrip = try await networkDispatcher.request(request).result

            XCTAssertEqual(response, .exploitsOfAMom)
        }
    }

#endif
