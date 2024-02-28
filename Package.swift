// swift-tools-version: 5.7

import PackageDescription

#if os(Linux)
let packageDependencies: [Package.Dependency] = [
    .package(url: "https://github.com/apple/swift-nio", from: "2.41.1"),
    .package(url: "https://github.com/apple/swift-nio-extras", from: "1.13.0"),
    .package(url: "https://github.com/swift-server/async-http-client", from: "1.11.5"),
]
let productDependencies: [Target.Dependency] = [
    .product(name: "AsyncHTTPClient", package: "async-http-client", condition: .when(platforms: [.linux])),
    .product(name: "NIOConcurrencyHelpers", package: "swift-nio", condition: .when(platforms: [.linux])),
    .product(name: "NIOHTTPCompression", package: "swift-nio-extras", condition: .when(platforms: [.linux])),
]
#else
let packageDependencies: [Package.Dependency] = []
let productDependencies: [Target.Dependency] = []
#endif

let package = Package(
    name: "KippleNetworking",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .tvOS(.v16),
        .watchOS(.v9),
    ],
    products: [
        .library(name: "KippleNetworking", targets: ["KippleNetworking"]),
    ],
    dependencies: packageDependencies + [
        .package(url: "https://github.com/swift-kipple/Diagnostics", .upToNextMinor(from: "0.3.6")),
        .package(url: "https://github.com/swift-kipple/Core", .upToNextMinor(from: "0.13.2")),
        .package(url: "https://github.com/swift-kipple/Tools", .upToNextMinor(from: "0.5.0")),
    ],
    targets: [
        // Product Targets
        .target(
            name: "KippleNetworking",
            dependencies: productDependencies + [
                .product(name: "KippleCodable", package: "Core"),
                .product(name: "KippleLogging", package: "Diagnostics"),
                .product(name: "KippleCore", package: "Core"),
            ]
        ),
        // Test Targets
        .testTarget(
            name: "KippleNetworkingTests",
            dependencies: [
                .target(name: "KippleNetworking"),
            ]
        ),
    ]
)
