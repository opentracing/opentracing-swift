// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "OpenTracing",
    platforms: [
        .iOS(.v11),
    ],
    products: [
        .library(
            name: "OpenTracing",
            targets: ["OpenTracing"]),
    ],
    targets: [
        .target(
            name: "OpenTracing",
            dependencies: [],
            path: "Sources")
    ]
)
