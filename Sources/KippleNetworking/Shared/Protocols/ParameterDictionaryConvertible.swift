// Copyright © 2024 Brian Drelling. All rights reserved.

public protocol ParameterDictionaryConvertible {
    func asParameterDictionary() -> [String: Any]?
}

public extension ParameterDictionaryConvertible where Self: Encodable {
    func asParameterDictionary() -> [String: Any]? {
        try? self.asDictionary()
    }
}

extension Dictionary: ParameterDictionaryConvertible where Key == String, Value == Any {
    public func asParameterDictionary() -> [String: Any]? {
        self
    }
}
