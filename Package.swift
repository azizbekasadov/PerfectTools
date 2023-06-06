// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "PerfectTools",
    platforms: [
        .macOS(.v10_13), .iOS(.v13), .tvOS(.v13)
    ],
    products: [
        .library(
            name: "PerfectTools",
            targets: ["PerfectTools"]),
    ],
    targets: [
        .target(
            name: "PerfectTools",
            dependencies: []),
        .testTarget(
            name: "PerfectToolsTests",
            dependencies: ["PerfectTools"]),
    ]
)
