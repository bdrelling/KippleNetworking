// Copyright © 2022 Brian Drelling. All rights reserved.

#if canImport(AsyncHTTPClient)

    import KippleNetworking
    import XCTest

    final class NIONetworkRequestDispatcherTests: XCTestCase {
        func testRequestSucceeds() async throws {
            let networkDispatcher = NIONetworkRequestDispatcher(baseURL: "https://xkcd.com")
            let request = GetXkcdStripRequest(id: XkcdStrip.exploitsOfAMom.num)

            do {
                let response: XkcdStrip = try await networkDispatcher.request(for: request).result
                XCTAssertEqual(response, .exploitsOfAMom)
            } catch {
                print(error.localizedDescription)
            }
        }

        func testRepeatedRequestsSucceed() async throws {
            let networkDispatcher = NIONetworkRequestDispatcher(baseURL: "https://xkcd.com")
            let request = GetXkcdStripRequest(id: XkcdStrip.exploitsOfAMom.num)

            do {
                let response: XkcdStrip = try await networkDispatcher.request(for: request).result
                XCTAssertEqual(response, .exploitsOfAMom)
            } catch {
                print(error.localizedDescription)
            }

            do {
                let response: XkcdStrip = try await networkDispatcher.request(for: request).result
                XCTAssertEqual(response, .exploitsOfAMom)
            } catch {
                print(error.localizedDescription)
            }
        }
    }

#endif
