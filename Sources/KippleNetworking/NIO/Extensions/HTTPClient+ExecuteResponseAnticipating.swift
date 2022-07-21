// Copyright © 2022 Brian Drelling. All rights reserved.

#if canImport(AsyncHTTPClient)

import AsyncHTTPClient
import Foundation
import NIO
import NIOHTTP1

extension AsyncHTTPClient.HTTPClient {
    func execute(_ request: KippleNetworking.Request, with environment: Environment, timeout: TimeAmount = .seconds(10)) async throws -> HTTPClientResponse {
        let clientRequest = try request.asHTTPClientRequest(with: environment)
        return try await self.execute(clientRequest, timeout: timeout)
    }
}

#endif
