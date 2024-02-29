import Foundation

public extension String {
    // ^https?://: Matches the beginning of the string followed by "http://" or "https://".
    // [^/?]+: Matches one or more characters that are not "/", "?", or "&".
    // \?: Matches the "?" character.
    // [^/?=&]+: Matches one or more characters that are not "/", "?", "=", or "&".
    // =: Matches the "=" character.
    // [^/?=&]+: Matches one or more characters that are not "/", "?", "=", or "&".
    // +: Matches one or more occurrences of the preceding pattern.
    private static let urlWithQueryStringRegexPattern = #"^https?://[^/?]+\?[^/?=&]+=[^/?=&]+"#
    
    /// Determines whether the string represents a URL with a query string.
    ///
    /// - Returns: `true` if the string is a URL with a query string, otherwise `false`.
    func isURLWithQueryString() -> Bool {
        let regex = try! NSRegularExpression(pattern: Self.urlWithQueryStringRegexPattern)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) != nil
    }
    
    /// Determines whether the string represents a URL with a query string containing specific parameters.
    ///
    /// - Parameter parameters: A dictionary representing the parameters to match in the query string.
    /// - Returns: `true` if the string is a URL with a query string containing the specified parameters, otherwise `false`.
    func isURLWithQueryString(containing parameters: [String: Any]) -> Bool {
        guard let urlComponents = URLComponents(string: self) else {
            return false
        }
        
        // Extract query items from the URL
        var queryStringParameters = [String: Any]()
        if let queryItems = urlComponents.queryItems {
            for item in queryItems {
                if let value = item.value {
                    queryStringParameters[item.name] = value
                }
            }
        }
        
        // Compare the query string parameters with the provided parameters
        return parameters.allSatisfy { key, value in
            queryStringParameters[key] != nil && "\(queryStringParameters[key]!)" == "\(value)"
        }
    }
}
