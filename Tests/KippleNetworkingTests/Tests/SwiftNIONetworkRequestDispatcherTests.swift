// Copyright © 2024 Brian Drelling. All rights reserved.

#if canImport(AsyncHTTPClient)

import KippleNetworking
import XCTest

final class NIONetworkRequestDispatcherTests: XCTestCase {
    func testRequestSucceeds() async throws {
        let environment = Environment(baseURL: "https://xkcd.com")
        let dispatcher = NIONetworkRequestDispatcher()
        let request = GetXKCDStripRequest(id: XKCDStrip.exploitsOfAMom.num)

        do {
            let response: XKCDStrip = try await dispatcher.response(for: request, with: environment)
            XCTAssertEqual(response, .exploitsOfAMom)
        } catch {
            print(error.localizedDescription)
        }
    }

    func testRepeatedRequestsSucceed() async throws {
        let environment = Environment(baseURL: "https://xkcd.com")
        let dispatcher = NIONetworkRequestDispatcher()
        let request = GetXKCDStripRequest(id: XKCDStrip.exploitsOfAMom.num)

        do {
            let response: XKCDStrip = try await dispatcher.response(for: request, with: environment)
            XCTAssertEqual(response, .exploitsOfAMom)
        } catch {
            print(error.localizedDescription)
        }

        do {
            let response: XKCDStrip = try await dispatcher.response(for: request, with: environment)
            XCTAssertEqual(response, .exploitsOfAMom)
        } catch {
            print(error.localizedDescription)
        }
    }
}

#endif
