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
        .package(url: "https://github.com/swift-server/async-http-client", .upToNextMajor(from: "1.3.0")),
        .package(url: "https://github.com/spothero/UtilityBelt-iOS", .upToNextMinor(from: "0.13.0")),
    ],
    targets: [
        .target(
            name: "KippleNetworking",
            dependencies: []
        ),
        .testTarget(
            name: "KippleNetworkingTests",
            dependencies: [
                .target(name: "KippleNetworking"),
            ]
        ),
    ]
)
