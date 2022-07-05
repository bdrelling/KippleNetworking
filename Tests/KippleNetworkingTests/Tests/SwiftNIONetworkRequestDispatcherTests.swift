// Copyright © 2022 Brian Drelling. All rights reserved.

#if canImport(AsyncHTTPClient)

    import KippleNetworking
    import XCTest

    final class SwiftNIONetworkRequestDispatcherTests: XCTestCase {
        func testRequestSucceeds() async throws {
            let networkDispatcher = SwiftNIONetworkRequestDispatcher(baseURL: "https://xkcd.com")
            let request = GetXkcdStripRequest(id: XkcdStrip.exploitsOfAMom.num)

            do {
                let response = try await networkDispatcher.request(request)
                XCTAssertEqual(response, .exploitsOfAMom)
            } catch {
                print(error.localizedDescription)
            }
        }

        func testRepeatedRequestsSucceed() async throws {
            let networkDispatcher = SwiftNIONetworkRequestDispatcher(baseURL: "https://xkcd.com")
            let request = GetXkcdStripRequest(id: XkcdStrip.exploitsOfAMom.num)

            do {
                let response = try await networkDispatcher.request(request)
                XCTAssertEqual(response, .exploitsOfAMom)
            } catch {
                print(error.localizedDescription)
            }

            do {
                let response = try await networkDispatcher.request(request)
                XCTAssertEqual(response, .exploitsOfAMom)
            } catch {
                print(error.localizedDescription)
            }
        }
    }

#endif
