// Copyright © 2022 Brian Drelling. All rights reserved.

#if os(iOS) || os(macOS) || os(tvOS) || os(watchOS)

    import Foundation
    import UtilityBeltNetworking

    extension Request {
        func asURLRequest(with environment: Environment) throws -> URLRequest {
            let baseURL = environment.baseURL.trimmingSlashes()
            let path = self.path.trimmingSlashes()

            let url = "\(baseURL)/\(path)"

            // Merge parameters together, preferring any overridden parameters on the request.
            let parameters = environment.parameters.merging(self.parameters, uniquingKeysWith: { _, parameter in parameter })

            // Merge HTTP headers together, preferring any overridden headers on the request.
            let headers = environment.headers.merging(self.headers, uniquingKeysWith: { _, header in header })

            return try .init(
                url: url,
                method: self.method,
                parameters: parameters,
                headers: headers,
                encoding: self.encoding
            )
        }
    }

#endif
