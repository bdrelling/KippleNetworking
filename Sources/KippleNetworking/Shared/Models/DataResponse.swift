// Copyright © 2022 Brian Drelling. All rights reserved.

import Foundation

#if canImport(AsyncHTTPClient)
import AsyncHTTPClient
#endif

/// The response that is returned by the server from an HTTP request.
public struct DataResponse<Result> {
    /// The request sent to the server.
    public let request: Request

    /// The status code returned by the server.
    public let status: HTTPStatusCode

    /// The data returned by the server.
    public let data: Data

    /// The decoded data returned by the server.
    public var result: Result

    /// Creates an `DataResponse` object composed of the result of an HTTP request.
    ///
    /// - Parameters:
    ///   - request:    The request sent to the server.
    ///   - status:     The status code returned by the server.
    ///   - data:       The data returned by the server.
    ///   - result:     The serialized result of the request sent to the server.
    public init(
        request: Request,
        status: HTTPStatusCode,
        data: Data,
        result: Result
    ) {
        self.request = request
        self.status = status
        self.data = data
        self.result = result
    }
}

// MARK: - Extensions

public extension DataResponse where Result == Data {
    init(
        request: Request,
        status: HTTPStatusCode,
        data: Data
    ) {
        self.request = request
        self.status = status
        self.data = data
        self.result = data
    }
}

#if os(iOS) || os(macOS) || os(tvOS) || os(watchOS)

extension DataResponse {
    init(request: Request, response: URLResponse, data: Data, result: Result) throws {
        if let status = (response as? HTTPURLResponse)?.status {
            self.init(request: request, status: status, data: data, result: result)
        } else {
            fatalError()
        }
    }
}

extension DataResponse where Result == Data {
    init(request: Request, response: URLResponse, data: Data) throws {
        try self.init(request: request, response: response, data: data, result: data)
    }
}

#endif

#if canImport(AsyncHTTPClient)

extension DataResponse {
    init(request: Request, response: HTTPClientResponse, data: Data, result: Result) throws {
        if let status = HTTPStatusCode(rawValue: Int(response.status.code)) {
            self.init(request: request, status: status, data: data, result: result)
        } else {
            fatalError()
        }
    }
}

extension DataResponse where Result == Data {
    init(request: Request, response: HTTPClientResponse, data: Data) throws {
        try self.init(request: request, response: response, data: data, result: data)
    }
}

#endif
