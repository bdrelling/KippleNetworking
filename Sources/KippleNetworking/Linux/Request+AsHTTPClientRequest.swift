// Copyright © 2022 Brian Drelling. All rights reserved.

#if canImport(AsyncHTTPClient)

    import AsyncHTTPClient
    import Foundation

    extension Request {
        func asHTTPClientRequest(with environment: Environment) throws -> AsyncHTTPClient.HTTPClient.Request {
            let baseURL = environment.baseURL.trimmingSlashes()
            let path = self.path.trimmingSlashes()

            var url = "\(baseURL)/\(path)"

            // Merge parameters together, preferring any overridden parameters on the request.
            let parameters = environment.parameters.merging(self.parameters, uniquingKeysWith: { _, parameter in parameter })

            // Attempt to encode the parameters into a query string and set them to the URL of the request.
            if case .queryString = self.encoding,
               var urlComponents = URLComponents(string: url) {
                urlComponents.setQueryItems(with: parameters)

                url = urlComponents.string ?? url
            }

            var clientRequest = try AsyncHTTPClient.HTTPClient.Request(url: url, method: .init(rawValue: self.method.rawValue))

            // Merge HTTP headers together, preferring any overridden headers on the request.
            let headers = environment.headers.merging(self.headers, uniquingKeysWith: { _, header in header })

            // Add HTTP headers to the request.
            headers.forEach {
                clientRequest.headers.add(name: $0.key, value: $0.value)
            }

            // If there are no parameters or the parameter encoding is not within the HTTP body, we can return the request.
            guard !parameters.isEmpty,
                  case let .httpBody(contentType) = self.encoding else {
                return clientRequest
            }

            // Set the Content-Type header for the request.
            clientRequest.headers.add(name: "Content-Type", value: contentType.rawValue)

            // Serialize the parmaeters into the necessary format and set the HTTP body of the request.
            switch contentType {
            case .json:
                let data = try parameters.asJSONSerializedData()
                clientRequest.body = .data(data)
            case .wwwFormURLEncoded:
                var urlComponents = URLComponents()
                urlComponents.setQueryItems(with: parameters)

                if let data = urlComponents.percentEncodedQuery?.data(using: .utf8) {
                    clientRequest.body = .data(data)
                } else {
                    // TODO: Throw Error
                }
            }

            return clientRequest
        }
    }

#endif
