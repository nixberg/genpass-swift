// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "genpass-swift",
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.2.0"),
    ],
    targets: [
        .target(
            name: "genpass",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ])
    ]
)
