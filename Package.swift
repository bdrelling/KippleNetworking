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
        .library(name: "KippleCodable", targets: ["KippleCodable"]),
        .library(name: "KippleNetworking", targets: ["KippleNetworking"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-nio", .upToNextMajor(from: "2.40.0")),
        .package(url: "https://github.com/apple/swift-nio-extras", .upToNextMajor(from: "1.12.1")),
        .package(url: "https://github.com/swift-server/async-http-client", .upToNextMajor(from: "1.11.1")),
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
                .product(
                    name: "AsyncHTTPClient",
                    package: "async-http-client"
                ),
                .product(name: "NIOConcurrencyHelpers", package: "swift-nio"),
                .product(name: "NIOHTTPCompression", package: "swift-nio-extras"),
                // Internal
                .target(name: "KippleCodable"),
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
