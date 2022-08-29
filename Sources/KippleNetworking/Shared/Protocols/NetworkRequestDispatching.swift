// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation
import Logging

public protocol NetworkRequestDispatching {
    var decoder: JSONDecoder { get }

    func request(_ request: Request, with environment: Environment, logger: Logger?) async throws -> DataResponse<Data>
    func requestDecoded<T>(_ request: Request, with environment: Environment, logger: Logger?) async throws -> DataResponse<T> where T: Decodable
    func response<T>(for request: T, with environment: Environment, logger: Logger?) async throws -> T.Response where T: ResponseAnticipating
}

// MARK: - Extensions

public extension NetworkRequestDispatching {
    func requestDecoded<T>(_ request: Request, with environment: Environment, logger: Logger? = nil) async throws -> DataResponse<T> where T: Decodable {
        let response: DataResponse<Data> = try await self.request(request, with: environment, logger: logger)
        let rootResponseKey = request.rootResponseKey ?? environment.rootResponseKey
        return try response.decoded(to: T.self, with: self.decoder, rootResponseKey: rootResponseKey, logger: logger)
    }

    // FIXME: How can this method match the same signature as other `request` methods without losing type safety or causing an infinite loop?
    func response<T>(for request: T, with environment: Environment, logger: Logger? = nil) async throws -> T.Response where T: ResponseAnticipating {
        try await self.requestDecoded(request, with: environment, logger: logger).result
    }
}

extension DataResponse where Result == Data {
    public enum ResponseDecodingError: Error {
        case invalidRootJSONResponseKey
    }

    private func replacing<T>(result: T) -> DataResponse<T> {
        .init(request: self.request, status: self.status, data: self.data, result: result)
    }

    fileprivate func decoded<T: Decodable>(to decodableType: T.Type, with decoder: JSONDecoder, rootResponseKey: String? = nil, logger: Logger? = nil) throws -> DataResponse<T> {
        var didLogJSONResponse = false

        do {
            guard let rootKey = rootResponseKey else {
                let result = try decoder.decodeCleaned(decodableType, from: self.data)
                logger?.debug(response: result, data: self.data)
                return self.replacing(result: result)
            }

            let responseDictionary = try decoder.decodeCleaned([String: T].self, from: data)

            // Log our JSON response if possible.
            logger?.debug(response: responseDictionary, data: self.data)
            // To avoid redundant logging, make a note that we logged the JSON response.
            didLogJSONResponse = true

            if let response = responseDictionary[rootKey] {
                return self.replacing(result: response)
            } else {
                throw ResponseDecodingError.invalidRootJSONResponseKey
            }
        } catch {
            // If we didn't yet log the JSON response, log it now using its raw data.
            if !didLogJSONResponse {
                logger?.debug(response: nil, data: self.data)
            }

            logger?.error("\(error.localizedDescription)")
            throw error
        }
    }
}

private extension Logger {
    func debug(response: Any?, data: Data) {
        do {
            // If the result is encodable, log it as a pretty-printed string.
            // If it is not, log it as a raw string
            if let encodedResponse = response as? Encodable {
                let prettyPrintedString = try encodedResponse.prettyPrinted()
                self.debug("JSON Response: \(prettyPrintedString)")
            } else if let rawResponse = String(data: data, encoding: .utf8) {
                self.debug("JSON Response: \(rawResponse)")
            }
        } catch {
            self.error("\(error.localizedDescription)")
        }
    }
}
