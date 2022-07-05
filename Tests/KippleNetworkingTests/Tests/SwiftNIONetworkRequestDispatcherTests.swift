// Copyright © 2022 Brian Drelling. All rights reserved.

#if canImport(AsyncHTTPClient)

    import KippleNetworking
    import XCTest

    final class SwiftNIONetworkRequestDispatcherTests: XCTestCase {
        func testRequestSucceeds() async throws {
            let networkDispatcher = SwiftNIONetworkRequestDispatcher(baseURL: "https://jsonplaceholder.typicode.com")
            let request = GetPostsRequest(id: 1)

            do {
                let response = try await networkDispatcher.request(request)

                XCTAssertEqual(response.id, 1)
                XCTAssertEqual(response.userId, 1)
                XCTAssertEqual(response.title, "sunt aut facere repellat provident occaecati excepturi optio reprehenderit")
                XCTAssertEqual(response.body, "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto")
            } catch {
                print(error.localizedDescription)
            }
        }

        func testRepeatedRequestsSucceed() async throws {
            let networkDispatcher = SwiftNIONetworkRequestDispatcher(baseURL: "https://jsonplaceholder.typicode.com")
            let request = GetPostsRequest(id: 1)

            do {
                let response = try await networkDispatcher.request(request)

                XCTAssertEqual(response.id, 1)
                XCTAssertEqual(response.userId, 1)
                XCTAssertEqual(response.title, "sunt aut facere repellat provident occaecati excepturi optio reprehenderit")
                XCTAssertEqual(response.body, "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto")
            } catch {
                print(error.localizedDescription)
            }

            do {
                let response = try await networkDispatcher.request(request)

                XCTAssertEqual(response.id, 1)
                XCTAssertEqual(response.userId, 1)
                XCTAssertEqual(response.title, "sunt aut facere repellat provident occaecati excepturi optio reprehenderit")
                XCTAssertEqual(response.body, "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto")
            } catch {
                print(error.localizedDescription)
            }
        }
    }

#endif
