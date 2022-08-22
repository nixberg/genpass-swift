// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "genpass-swift",
    platforms: [
        .macOS(.v10_15),
    ],
    products: [
        .executable(name: "genpass", targets: ["Genpass"]),
        .executable(name: "format-word-list", targets: ["WordListFormatter"]),
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
            ],
            swiftSettings: [
                .unsafeFlags(["-cross-module-optimization"], .when(configuration: .release))
            ]),
        .executableTarget(
            name: "WordListFormatter",
            dependencies: [
                .product(name: "Algorithms", package: "swift-algorithms"),
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]),
        .target(
            name: "PasswordGenerators",
            dependencies: [
                .product(name: "Algorithms", package: "swift-algorithms"),
                .product(name: "Numerics", package: "swift-numerics"),
            ]),
    ]
)
