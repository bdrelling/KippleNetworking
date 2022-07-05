// Copyright © 2022 Brian Drelling. All rights reserved.

@testable import KippleNetworking
import XCTest

final class KippleNetworkingTests: XCTestCase {
    func testRequestSucceeds() async throws {
        let networkDispatcher = NetworkRequestDispatcher(baseURL: "https://jsonplaceholder.typicode.com")
        let request = GetExamplePostsRequest(id: 1)
        let response = try await networkDispatcher.request(request)

        XCTAssertEqual(response.id, 1)
        XCTAssertEqual(response.userId, 1)
        XCTAssertEqual(response.title, "sunt aut facere repellat provident occaecati excepturi optio reprehenderit")
        XCTAssertEqual(response.body, "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto")
    }
}

// TODO: Use Xkcd service? https://github.com/swift-server/async-http-client/blob/main/Examples/GetJSON/GetJSON.swift
public struct GetExamplePostsRequest: Request, ResponseAnticipating {
    private enum Parameters: String {
        case id
    }

    public var path: String {
        "/posts/\(self.id)"
    }

    public private(set) var parameters: [String: Any] = [:]

    private let id: Int

    public init(id: Int) {
        self.parameters[Parameters.id.rawValue] = id
        self.id = id
    }

    public struct Response: Decodable {
        public let userId: Int
        public let id: Int
        public let title: String
        public let body: String
    }
}
