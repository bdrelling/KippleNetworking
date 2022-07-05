// Copyright © 2022 Brian Drelling. All rights reserved.

#if os(iOS) || os(macOS) || os(tvOS) || os(watchOS)

    @testable import KippleNetworking
    import XCTest

    final class FoundationNetworkRequestDispatcherTests: XCTestCase {
        func testRequestSucceeds() async throws {
            let networkDispatcher = FoundationNetworkRequestDispatcher(baseURL: "https://jsonplaceholder.typicode.com")
            let request = GetPostsRequest(id: 1)
            let response = try await networkDispatcher.request(request)

            XCTAssertEqual(response.id, 1)
            XCTAssertEqual(response.userId, 1)
            XCTAssertEqual(response.title, "sunt aut facere repellat provident occaecati excepturi optio reprehenderit")
            XCTAssertEqual(response.body, "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto")
        }
    }

#endif
