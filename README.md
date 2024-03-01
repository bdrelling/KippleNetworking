# KippleNetworking

[![Latest Release](https://img.shields.io/github/v/tag/bdrelling/KippleNetworking?color=blue&label=)](https://github.com/bdrelling/KippleNetworking/tags)
[![Swift Compatibility](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fbdrelling%2FKippleNetworking%2Fbadge%3Ftype%3Dswift-versions&label=)](https://swiftpackageindex.com/bdrelling/KippleNetworking)
[![Platform Compatibility](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fbdrelling%2FKippleNetworking%2Fbadge%3Ftype%3Dplatforms&label=)](https://swiftpackageindex.com/bdrelling/KippleNetworking)
[![License](https://img.shields.io/github/license/bdrelling/KippleNetworking?label=)](https://github.com/bdrelling/KippleNetworking/blob/main/LICENSE)  
[![Apple CI Status](https://github.com/bdrelling/KippleNetworking/actions/workflows/apple_tests.yml/badge.svg)](https://github.com/bdrelling/KippleNetworking/actions/workflows/apple_tests.yml)
[![Linux CI Status](https://github.com/bdrelling/KippleNetworking/actions/workflows/linux_tests.yml/badge.svg)](https://github.com/bdrelling/KippleNetworking/actions/workflows/linux_tests.yml)
[![Code Coverage](https://img.shields.io/codecov/c/github/bdrelling/KippleNetworking)](https://codecov.io/gh/bdrelling/KippleNetworking)

A Swift library that offers cross-platform (Apple and Linux) networking support, intended for the creation of cross-platform SDKs to be used in projects spanning across iOS/macOS/tvOS/watchOS and Server-side Swift.

> [!WARNING]
> The code in this library has been made public as-is solely for the purposes of reference, education, discovery, and personal use. As such, stability for production applications **CANNOT** be guaranteed; however, if you're interested in leveraging code within this library in your own projects, feel free to do so at your own risk.
>
> Please open GitHub issues for any problems you encounter or requests you have and we will do my best to provide support.

## Table of Contents

- [Documentation](#documentation)
  - [Modules](#modules)
  - [Dependencies](#dependencies)
- [Kipple Libraries](#kipple-libraries)
- [Installation](#installation)
- [Maintenance](#maintenance)
- [Compatibility](#compatibility)
- [Stability](#stability)
- [Contributing](#contributing)
- [License](#license)

## Documentation

### Modules

- [KippleNetworking](/Sources/KippleNetworking) — Cross-platform (Apple and Linux) networking support.

### Dependencies

- [Kipple](https://github.com/bdrelling/Kipple) — A collection of Swift modules providing common Swift functionality.
- [apple/swift-nio](https://github.com/apple/swift-nio) — Event-driven network application framework for high performance protocol servers & clients, non-blocking.
- [apple/swift-nio-extras](https://github.com/apple/swift-nio-extras) — Useful code around SwiftNIO.
- [swift-server/async-http-client](https://github.com/swift-server/async-http-client) — HTTP client library built on SwiftNIO.

> [!NOTE]  
> This package also utilizes [KippleTools](https://github.com/bdrelling/KippleTools) as a development dependency, which handles linting, formatting, and other core scripting needs for [Kipple](https://github.com/bdrelling/Kipple) projects.
> This dependency is not pulled into your project in any way, as it is not referenced directly by any product of this package.

## Kipple Libraries

There's more where this came from!

Check out [Kipple](https://github.com/bdrelling/Kipple) and its [component libraries](https://github.com/bdrelling/Kipple#component-libraries).

## Installation

See [Installation](https://github.com/bdrelling/Kipple#installation).

## Compatibility

[![Swift Compatibility](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fbdrelling%2FKippleNetworking%2Fbadge%3Ftype%3Dswift-versions&label=)](https://swiftpackageindex.com/bdrelling/KippleNetworking)
[![Platform Compatibility](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fbdrelling%2FKippleNetworking%2Fbadge%3Ftype%3Dplatforms&label=)](https://swiftpackageindex.com/bdrelling/KippleNetworking)

See [Compatibility](https://github.com/bdrelling/Kipple#compatibility).

## Stability

See [Stability](https://github.com/bdrelling/Kipple#stability).

## Contributing

Sorry to do this to you again, but...

See [Contributing](https://github.com/bdrelling/Kipple#contributing).

## License

All **Kipple** libraries are released under the MIT license. See [LICENSE](LICENSE) for details.
