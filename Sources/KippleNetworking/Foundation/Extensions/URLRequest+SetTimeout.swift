// Copyright © 2024 Brian Drelling. All rights reserved.

#if os(iOS) || os(macOS) || os(tvOS) || os(watchOS)

import Foundation

extension URLRequest {
    /// The default timeout interval is 60. This value is used whenever `nil` is received by an applicable method.
    /// Source: https://developer.apple.com/documentation/foundation/urlrequest/2011509-timeoutinterval
    static let defaultTimeoutInterval: TimeInterval = 60

    mutating func setTimeout(_ timeoutInterval: TimeInterval?) {
        // Set the timeout interval of the request if timeoutInterval is not nil, otherwise reset to the default.
        if let timeoutInterval = timeoutInterval {
            self.timeoutInterval = timeoutInterval
        } else {
            self.timeoutInterval = Self.defaultTimeoutInterval
        }
    }

    func withTimeout(_ timeoutInterval: TimeInterval?) -> URLRequest {
        var request = self
        request.setTimeout(timeoutInterval)

        return request
    }
}

#endif
