// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "KippleNetworking",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v8),
    ],
    products: [
        .library(name: "KippleNetworking", targets: ["KippleNetworking"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-nio", .upToNextMajor(from: "2.40.0")),
        .package(url: "https://github.com/apple/swift-nio-extras", .upToNextMajor(from: "1.12.1")),
        .package(url: "https://github.com/swift-server/async-http-client", .upToNextMajor(from: "1.11.1")),
        .package(url: "https://github.com/spothero/UtilityBelt-iOS", .upToNextMinor(from: "0.13.0")),
    ],
    targets: [
        .target(
            name: "KippleNetworking",
            dependencies: [
                // TODO: Use condition check for Linux-only dependencies, but only for Release mode.
                // Example: 'condition: .when(platforms: [.linux])'
                .product(
                    name: "AsyncHTTPClient",
                    package: "async-http-client"
                ),
                .product(name: "NIOConcurrencyHelpers", package: "swift-nio"),
                .product(name: "NIOHTTPCompression", package: "swift-nio-extras"),
                .product(
                    name: "UtilityBeltNetworking",
                    package: "UtilityBelt-iOS",
                    condition: .when(platforms: [.iOS, .macOS, .tvOS, .watchOS])
                ),
            ],
            swiftSettings: [
                .define("DEBUG", .when(configuration: .debug)),
            ]
        ),
        .testTarget(
            name: "KippleNetworkingTests",
            dependencies: [
                .target(name: "KippleNetworking"),
            ]
        ),
    ]
)
