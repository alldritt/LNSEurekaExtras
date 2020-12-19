// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LNSEurekaExtras",
    products: [
        .library(
            name: "LNSEurekaExtras",
            targets: ["LNSEurekaExtras"]),
    ],
    dependencies: [
        .package(url: "https://github.com/xmartlabs/Eureka.git", from: "5.3.2"),
    ],
    targets: [
        .target(
            name: "LNSEurekaExtras",
            dependencies: ["Eureka"])
    ]
)
