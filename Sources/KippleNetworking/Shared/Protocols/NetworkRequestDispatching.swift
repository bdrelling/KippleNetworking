// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

public protocol NetworkRequestDispatching {
    var decoder: JSONDecoder { get }

    func request(_ request: Request, with environment: Environment) async throws -> DataResponse<Data>
}

// MARK: - Extensions

public extension NetworkRequestDispatching {
    func requestDecoded<T>(_ request: Request, with environment: Environment) async throws -> DataResponse<T> where T: Decodable {
        let response: DataResponse<Data> = try await self.request(request, with: environment)
        let rootResponseKey = request.rootResponseKey ?? environment.rootResponseKey
        return try response.decoded(to: T.self, with: self.decoder, rootResponseKey: rootResponseKey)
    }

    // FIXME: How can this method match the same signature as other `request` methods without losing type safety or causing an infinite loop?
    func response<T>(for request: T, with environment: Environment) async throws -> T.Response where T: ResponseAnticipating {
        try await self.requestDecoded(request, with: environment).result
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
        do {
            guard let rootKey = rootResponseKey else {
                let result = try decoder.decodeCleaned(decodableType, from: self.data)
                return self.replacing(result: result)
            }
            
            let responseDictionary = try decoder.decodeCleaned([String: T].self, from: data)
            
            if let response = responseDictionary[rootKey] {
                return self.replacing(result: response)
            } else {
                throw ResponseDecodingError.invalidRootJSONResponseKey
            }
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
}
