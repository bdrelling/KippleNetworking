// Copyright © 2024 Brian Drelling. All rights reserved.

import Foundation

#if canImport(AsyncHTTPClient)
import AsyncHTTPClient
#endif

public extension UniversalNetworkRequestDispatcher {
    enum DispatchMode {
        #if os(iOS) || os(macOS) || os(tvOS) || os(watchOS)
        case appleFoundation(URLSession = .shared)
        #endif

        #if canImport(AsyncHTTPClient)
        case swiftNIO(AsyncHTTPClient.HTTPClient? = nil)
        #endif

        public func configured(decoder: JSONDecoder? = nil) -> NetworkRequestDispatching {
            switch self {
            #if os(iOS) || os(macOS) || os(tvOS) || os(watchOS)
            case let .appleFoundation(session):
                return FoundationNetworkRequestDispatcher(decoder: decoder, session: session)
            #endif

            #if canImport(AsyncHTTPClient)
            case let .swiftNIO(client):
                return NIONetworkRequestDispatcher(decoder: decoder, client: client)
            #endif
            }
        }
    }
}

#if os(iOS) || os(macOS) || os(tvOS) || os(watchOS)
public extension UniversalNetworkRequestDispatcher.DispatchMode {
    static let automatic: Self = .appleFoundation(.shared)
}

#elseif canImport(AsyncHTTPClient)

public extension UniversalNetworkRequestDispatcher.DispatchMode {
    static let automatic: Self = .swiftNIO(.init(eventLoopGroupProvider: .singleton))
}

#endif
