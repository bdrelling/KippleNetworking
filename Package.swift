// swift-tools-version:5.3

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
        // All dependencies in this package are conditional to support the broadest range of Swift versions.
        // See the bottom of this package for more information.
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

#if swift(>=5.5)
// Add Kipple Tools if possible.
package.dependencies.append(
    .package(url: "https://github.com/swift-kipple/Tools", from: "0.2.5")
)
#endif

#if swift(>=5.4)
package.dependencies.append(contentsOf: [
    .package(url: "https://github.com/apple/swift-nio", from: "2.41.1"),
    .package(url: "https://github.com/apple/swift-nio-extras", from: "1.12.1"),
    .package(url: "https://github.com/swift-server/async-http-client", from: "1.11.5"),
])
#elseif swift(>=5.3)
package.dependencies.append(contentsOf: [
    .package(url: "https://github.com/apple/swift-nio", .exact("2.39.0")),
    .package(url: "https://github.com/apple/swift-nio-extras", .exact("1.10.2")),
    .package(url: "https://github.com/swift-server/async-http-client", .exact("1.9.0")),
])
#endif
