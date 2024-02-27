// Copyright © 2024 Brian Drelling. All rights reserved.

#if os(iOS) || os(macOS) || os(tvOS) || os(watchOS)

import Foundation

public extension URLRequest {
    /// Creates a configured URLRequest.
    /// - Parameter url: The URL for the request. Accepts a URL or a String.
    /// - Parameter method: The HTTP method for the request. Defaults to `GET`.
    /// - Parameter parameters: The parameters to be converted into a String-keyed dictionary to send in the query string or HTTP body.
    /// - Parameter body: The raw data to be set as the HTTP body of the request. If this value is not nil, then `encoding` must _not_ be `.httpBody`.
    /// - Parameter headers: The HTTP headers to send with the request.
    /// - Parameter encoding: The parameter encoding method. If nil, uses the default encoding for the provided HTTP method.
    /// - Returns: The configured `URLRequest` object.
    init(
        url: URLConvertible,
        method: HTTPMethod = .get,
        parameters: ParameterDictionaryConvertible? = nil,
        body: Data? = nil,
        headers: [String: String] = [:],
        encoding: ParameterEncoding? = nil
    ) throws {
        if case .httpBody = encoding, body?.isEmpty != false {
            throw NetworkingError.httpBodyConflictsWithParameterEncoding
        }

        let url = try url.asURL()
        self.init(url: url)

        self.httpMethod = method.rawValue

        self.setHeaders(headers)

        // Parameters must be set after setting headers, because encoding dictates (and therefore overrides) the Content-Type header
        self.setParameters(parameters, method: method, encoding: encoding)

        self.httpBody = body
    }

    init(
        url: URLConvertible,
        method: HTTPMethod = .get,
        parameters: ParameterDictionaryConvertible? = nil,
        body: Data? = nil,
        headers: [HTTPHeader: String],
        encoding: ParameterEncoding? = nil
    ) throws {
        try self.init(
            url: url,
            method: method,
            parameters: parameters,
            body: body,
            headers: headers.asHeaderDictionary(),
            encoding: encoding
        )
    }
}

#endif
