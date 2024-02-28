// Copyright © 2024 Brian Drelling. All rights reserved.

import KippleCodable

public protocol ParameterDictionaryConvertible {
    func asParameterDictionary() -> [String: Any]?
}

public extension ParameterDictionaryConvertible where Self: Encodable {
    func asParameterDictionary() -> [String: Any]? {
        try? self.asDictionary(encoder: .safeISO8601)
    }
}

extension Dictionary: ParameterDictionaryConvertible where Key == String, Value == Any {
    public func asParameterDictionary() -> [String: Any]? {
        self
    }
}
