# KippleNetworking

[![CI Status](https://github.com/bdrelling/KippleNetworking/actions/workflows/tests.yml/badge.svg)](https://github.com/bdrelling/KippleNetworking/actions/workflows/tests.yml)
[![Latest Release](https://img.shields.io/github/v/tag/bdrelling/KippleNetworking?color=blue&label=)](https://github.com/bdrelling/KippleNetworking/tags)
[![Swift Compatibility](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fbdrelling%2FKippleNetworking%2Fbadge%3Ftype%3Dswift-versions&label=)](https://swiftpackageindex.com/bdrelling/KippleNetworking)
[![Platform Compatibility](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fbdrelling%2FKippleNetworking%2Fbadge%3Ftype%3Dplatforms&label=)](https://swiftpackageindex.com/bdrelling/KippleNetworking)
[![License](https://img.shields.io/github/license/bdrelling/KippleNetworking?label=)](https://github.com/bdrelling/KippleNetworking/blob/main/LICENSE)

A Swift library that offers cross-platform (Apple and Linux) networking support, intended for the creation of cross-platform SDKs to be used in projects spanning across iOS/macOS/tvOS/watchOS/visionOS and Server-side Swift.

> [!WARNING]
> The code in this library has been made public as-is solely for the purposes of reference, education, discovery, and personal use. As such, stability for production applications **CANNOT** be guaranteed; however, if you're interested in leveraging code within this library in your own projects, feel free to do so at your own risk.
>
> Please open GitHub issues for any problems you encounter or requests you have and we will do my best to provide support.

## Table of Contents

- [Documentation](#documentation)
  - [Modules](#modules)
  - [Dependencies](#dependencies)
- [Installation](#installation)
- [Kipple Libraries](#kipple-libraries)
- [Maintenance](#maintenance)
- [Compatibility](#compatibility)
- [Stability](#stability)
- [Contributing](#contributing)
- [License](#license)

## Documentation

### Modules

- [Kipple](/Sources/Kipple) — An umbrella module that implicitly imports all other modules.
- [KippleCodable](/KippleCodable) — Convenience functionality for `Codable`.
- [KippleCollections](/KippleCollections) — Convenience functionality for `Collections`. Imports the `OrderedCollections` module of `swift-collections`.
- [KippleCombine](/KippleCombine) — Convenience functionality for `Combine`.
- [KippleCore](/KippleCore) — Convenience functionality for `Foundation`.
- [KippleDevice](/KippleDevice) — TBD
- [KippleKeychain](/KippleKeychain) — Convenience functionality for [Apple Keychain Services](https://developer.apple.com/documentation/security/keychain_services/).
- [KippleLocalStorage](/KippleLocalStorage) — Convenience Functionality for `UserDefaults`.
- [KippleLogging](/KippleLogging) — Convenience Functionality for `OSLog` on Apple platforms, and `swift-log` on other platforms.

### Dependencies

TODO: Update this section

## Kipple Libraries

There's more where this came from!

Check out [Kipple](https://github.com/bdrelling/Kipple) and its [component libraries](https://github.com/bdrelling/Kipple#component-libraries).

## Installation

See [Installation](https://github.com/bdrelling/Kipple#installation).

## Maintenance

See [Maintenance](https://github.com/bdrelling/Kipple#maintenance).

## Compatibility

See [Compatibility](https://github.com/bdrelling/Kipple#compatibility).

## Stability

See [Stability](https://github.com/bdrelling/Kipple#stability).

## Contributing

See [Contributing](https://github.com/bdrelling/Kipple#contributing).

## License

All **Kipple** libraries are released under the MIT license. See [LICENSE](LICENSE) for details.
