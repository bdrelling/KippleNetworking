# KippleNetworking

[![CI Status](https://github.com/bdrelling/KippleNetworking/actions/workflows/test.yml/badge.svg)](https://github.com/bdrelling/KippleNetworking/actions/workflows/tests.yml)
[![Latest Release](https://img.shields.io/github/v/tag/bdrelling/KippleNetworking?color=blue&label=latest)](https://github.com/bdrelling/KippleNetworking/releases)
[![Swift Version](https://img.shields.io/static/v1?label=swift&message=5.6&color=red&logo=swift&logoColor=white)](https://developer.apple.com/swift)
[![Platform Support](https://img.shields.io/static/v1?label=platform&message=iOS%20|%20macOS%20|%20watchOS%20|%20tvOS%20|%20Linux&color=darkgray)](https://github.com/bdrelling/KippleNetworking/blob/main/Package.swift)
[![License](https://img.shields.io/github/license/bdrelling/KippleNetworking)](https://github.com/bdrelling/KippleNetworking/blob/main/LICENSE)


A Swift library that offers cross-platform (Apple and Linux) networking support, intended for the creation of cross-platform SDKs to be used in projects spanning across iOS/macOS/tvOS/watchOS and Server-side Swift.

> :warning: The code in this library has been made public as-is for the purposes of education, discovery, and personal use. Is it **NOT** production-ready; however, if you're interested in leveraging this library as a dependency for your own projects, feel free to do so (at your own risk) and open GitHub issue for any problems you encounter and I will do my best to provide support.

## ToDo

### General
- Ensure public classes are documented (use SwiftLint to trigger warnings).
- Abstract client implementation for injection. (eg. to allow other clients to be injected / used as dispatcher.)
- Improve package dependencies for various platforms (eg. default to only including Foundation on Apple platforms unless some flag is set)? Example: 'condition: .when(platforms: [.linux])' to check for Linux-only dependencies, but only for Release mode.

### Testing
- Implement `POST` and `PUT` tests.
- Implement HTML tests.
- Implement file upload and download tests.
- Implement tests for `HTTPClient`.
- Implement tests for `rootResponseKey`.
- Implement tests for headers and parameters.

### Convenience
- On Apple platforms, all direct passing of `URLRequest` into `HTTPClient`. Example:

```swift
extension HTTPClient {
    #if os(iOS) || os(macOS) || os(tvOS) || os(watchOS)
    public func request(for urlRequest: URLRequest) async throws -> Data {
        let request = urlRequest.asKippleRequest()
        return try await self.request(request)
    }
    
    public func request<T>(for urlRequest: URLRequest) async throws -> DataResponse<T> where T: Decodable {
        let request = urlRequest.asKippleRequest()
        return try await self.request(request)
    }
    #endif
}
```
