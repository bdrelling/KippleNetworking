// swift-tools-version: 5.7

import PackageDescription

// Since we rely on URLSession for efficient networking on Apple platforms, we strip the NIO dependencies out for those targets.
// If you want to use Swift NIO and AsyncHTTPClient on Apple platforms, you should be able to simply remove this check
// and include the package and product dependencies directly in their respective locations.
#if os(Linux)
let packageDependencies: [Package.Dependency] = [
    .package(url: "https://github.com/apple/swift-nio", from: "2.63.0"),
    .package(url: "https://github.com/apple/swift-nio-extras", from: "1.21.0"),
    .package(url: "https://github.com/swift-server/async-http-client", from: "1.20.1"),
]
let productDependencies: [Target.Dependency] = [
    .product(name: "AsyncHTTPClient", package: "async-http-client"),
    .product(name: "NIOConcurrencyHelpers", package: "swift-nio"),
    .product(name: "NIOHTTPCompression", package: "swift-nio-extras"),
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
        .package(url: "https://github.com/bdrelling/Kipple", revision: "f1d909107828d12c863ba10c847cea6bfc45e139"),
        .package(url: "https://github.com/bdrelling/KippleTools", .upToNextMinor(from: "0.5.0")),
    ],
    targets: [
        // Product Targets
        .target(
            name: "KippleNetworking",
            dependencies: productDependencies + [
                .product(name: "KippleCodable", package: "Kipple"),
                .product(name: "KippleFoundation", package: "Kipple"),
                .product(name: "KippleLogging", package: "Kipple"),
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
