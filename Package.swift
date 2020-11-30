// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "xcconfig-buddy",
    products: [
        .executable(name: "xcconfig-buddy", targets: ["xcconfig-buddy"]),
        .library(name: "ConfigKit", targets: ["ConfigKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.3.1"),
    ],
    targets: [
        .target(
            name: "xcconfig-buddy",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "ConfigKit",
            ]
        ),
        .target(
            name: "ConfigKit",
            dependencies: []
        ),
        .testTarget(
            name: "xcconfig-buddyTests",
            dependencies: ["xcconfig-buddy"]),
    ]
)
