// Copyright © 2024 Brian Drelling. All rights reserved.

#if os(iOS) || os(macOS) || os(tvOS) || os(watchOS)

import Foundation

extension URLRequest {
    /// Set a value for the header field.
    /// - Parameters:
    ///   - value: The new value for the header field. Any existing value for the field is replaced by the new value.
    ///   - field: The `HTTPHeader` enum value of the header field to set.
    mutating func setValue(_ value: String?, forHTTPHeaderField field: HTTPHeader) {
        self.setValue(value, forHTTPHeaderField: field.rawValue)
    }

    /// Sets values for header fields in a given dictionary.
    /// - Parameter headers: The dictionary of HTTP headers to set.
    mutating func setHeaders(_ headers: [String: String]) {
        for header in headers {
            self.setValue(header.value, forHTTPHeaderField: header.key)
        }
    }

    /// Sets values for header fields in a given dictionary.
    /// - Parameter headers: The dictionary of HTTP headers to set.
    mutating func setHeaders(_ headers: [HTTPHeader: String]) {
        self.setHeaders(headers.asHeaderDictionary())
    }
}

#endif
