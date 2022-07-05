// Copyright © 2022 Brian Drelling. All rights reserved.

#if os(iOS) || os(macOS) || os(tvOS) || os(watchOS)

    import Combine
    import Foundation
    import UtilityBeltNetworking

    public final class FoundationNetworkRequestDispatcher {
        public let client: UtilityBeltNetworking.HTTPClient
        public let environment: Environment
        public let decoder: JSONDecoder = .safeISO8601

        public init(environment: Environment) {
            self.environment = environment
            self.client = Self.configuredClient()
        }
    }

    extension FoundationNetworkRequestDispatcher: NetworkRequestDispatching {
        public func request<T: ResponseAnticipating>(_ request: T) async throws -> T.Response {
            let urlRequest = try request.asURLRequest(with: self.environment)

            let (data, _) = try await URLSession.shared.data(for: urlRequest)

            print("WOWIEE")
            print(String(data: data, encoding: .utf8))

            return try self.decoder.decode(T.Response.self, from: data)
        }

        public static func configuredClient() -> UtilityBeltNetworking.HTTPClient {
            .init()
        }
    }

#endif

// #if canImport(Combine)
//
//    // TODO: Implement more generic support: https://swiftbysundell.com/articles/creating-combine-compatible-versions-of-async-await-apis/
//    public extension FoundationNetworkRequestDispatcher {
//        func request<T: ResponseAnticipating>(_ request: T) -> AnyPublisher<T.Response, Error> {
//            let urlRequest: URLRequest
//
//            do {
//                urlRequest = try request.asURLRequest(with: self.environment)
//            } catch {
//                return Result<T.Response, Error>.Publisher(error)
//                    .eraseToAnyPublisher()
//            }
//
//            return self.client
//                .requestPublisher(urlRequest, decoder: self.decoder)
//        }
//    }
//
// #endif
