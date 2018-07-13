// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "OpenTracingSwift",
    products: [
        .library(
            name: "OpenTracing",
            targets: ["OpenTracing"]),
    ],
    targets: [
        .target(
            name: "OpenTracing",
            dependencies: [])
    ]
)
