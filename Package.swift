// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "genpass-swift",
    products: [
        .executable(name: "genpass", targets: ["Genpass"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-algorithms", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-numerics", from: "1.0.0"),
    ],
    targets: [
        .executableTarget(
            name: "Genpass",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "PasswordGenerators",
            ]),
        .target(
            name: "PasswordGenerators",
            dependencies: [
                .product(name: "Algorithms", package: "swift-algorithms"),
                .product(name: "Numerics", package: "swift-numerics"),
            ],
            resources: [
                .copy("BIP39"),
            ]),
    ]
)
