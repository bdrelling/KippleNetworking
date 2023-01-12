// Copyright © 2023 Brian Drelling. All rights reserved.

#if os(iOS) || os(macOS) || os(tvOS) || os(watchOS)

import Foundation

extension Request {
    func asURLRequest(with environment: Environment) throws -> URLRequest {
        let baseURL = self.baseURL ?? environment.baseURL.trimmingSlashes()
        let path = self.path.trimmingSlashes()

        let url = {
            if path.isEmpty {
                return baseURL
            } else {
                return "\(baseURL)/\(path)"
            }
        }()

        // Merge parameters together, preferring any overridden parameters on the request.
        let parameters = environment.parameters.merging(self.parameters, uniquingKeysWith: { _, parameter in parameter })

        // Merge HTTP headers together, preferring any overridden headers on the request.
        let headers = environment.headers.merging(self.headers, uniquingKeysWith: { _, header in header })

        return try .init(
            url: url,
            method: .init(rawValue: self.method.rawValue) ?? .get,
            parameters: parameters,
            headers: headers,
            encoding: self.encoding
        )
    }
}

#endif
