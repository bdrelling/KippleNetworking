// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "KippleNetworking",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6),
    ],
    products: [
        .library(name: "KippleCodable", targets: ["KippleCodable"]),
        .library(name: "KippleNetworking", targets: ["KippleNetworking"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-nio", from: "2.41.1"),
        .package(url: "https://github.com/apple/swift-nio-extras", from: "1.13.0"),
        .package(url: "https://github.com/swift-server/async-http-client", from: "1.11.5"),
        .package(url: "https://github.com/swift-kipple/Tools", from: "0.3.0"),
    ],
    targets: [
        // Product Targets
        .target(
            name: "KippleCodable",
            dependencies: []
        ),
        .target(
            name: "KippleNetworking",
            dependencies: [
                .product(name: "AsyncHTTPClient", package: "async-http-client"),
                .product(name: "NIOConcurrencyHelpers", package: "swift-nio"),
                .product(name: "NIOHTTPCompression", package: "swift-nio-extras"),
            ],
            swiftSettings: [
                .define("DEBUG", .when(configuration: .debug)),
            ]
        ),
        // Test Targets
        .testTarget(
            name: "KippleCodableTests",
            dependencies: [
                .target(name: "KippleCodable"),
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
