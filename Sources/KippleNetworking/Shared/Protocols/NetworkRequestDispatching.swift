// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

public protocol NetworkRequestDispatching {
    var environment: Environment { get }
    var decoder: JSONDecoder { get }

    func request(_ request: Request) async throws -> DataResponse<Data>
}

// MARK: - Extensions

public extension NetworkRequestDispatching {
    func request<T>(_ request: Request) async throws -> DataResponse<T> where T: Decodable {
        let response = try await self.request(request)
        return try response.decoded(to: T.self, with: self.decoder, rootResponseKey: self.environment.rootResponseKey)
    }

    // FIXME: How can this method match the same signature as other `request` methods without losing type safety or causing an infinite loop?
    func response<T>(for request: T) async throws -> T.Response where T: ResponseAnticipating {
        try await self.request(request).result
    }
}

extension DataResponse where Result == Data {
    public enum ResponseDecodingError: Error {
        case invalidRootJSONResponseKey
    }

    private func replacing<T>(result: T) -> DataResponse<T> {
        .init(request: self.request, status: self.status, data: self.data, result: result)
    }

    fileprivate func decoded<T: Decodable>(to decodableType: T.Type, with decoder: JSONDecoder, rootResponseKey: String? = nil) throws -> DataResponse<T> {
        guard let rootKey = rootResponseKey else {
            let result = try decoder.decode(decodableType, from: self.data)
            return self.replacing(result: result)
        }

        let responseDictionary = try decoder.decode([String: T].self, from: data)

        if let response = responseDictionary[rootKey] {
            return self.replacing(result: response)
        } else {
            throw ResponseDecodingError.invalidRootJSONResponseKey
        }
    }
}
