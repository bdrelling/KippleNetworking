// Copyright © 2022 Brian Drelling. All rights reserved.

#if canImport(AsyncHTTPClient)

    import AsyncHTTPClient
    import Foundation
    import NIO
    import NIOHTTP1

    extension HTTPClient {
        func execute<T: ResponseAnticipating>(request: T, with environment: Environment) -> EventLoopFuture<Response> {
            do {
                let clientRequest = try request.asHTTPClientRequest(with: environment)
                return self.execute(request: clientRequest)
            } catch {
                return self.eventLoopGroup.next().makeFailedFuture(error)
            }
        }
    }

#endif
