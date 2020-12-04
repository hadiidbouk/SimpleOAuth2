// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SimpleOAuth2",
    platforms: [
        .iOS(.v13),
        .macOS(.v11),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        
        .library(
            name: "SimpleOAuth2",
            targets: ["SimpleOAuth2"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SimpleOAuth2",
            dependencies: []),
        .testTarget(
            name: "SimpleOAuth2Tests",
            dependencies: ["SimpleOAuth2"]),
    ]
)
