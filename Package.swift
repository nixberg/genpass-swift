// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "genpass",
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.1.0"),
    ],
    targets: [
        .target(
            name: "genpass",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]),
    ]
)
