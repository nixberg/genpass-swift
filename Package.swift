// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "genpass-swift",
    products: [
        .executable(
            name: "genpass",
            targets: ["Genpass"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-argument-parser",
            .upToNextMajor(from: "1.3.0")),
        .package(
            url: "https://github.com/apple/swift-algorithms",
            .upToNextMajor(from: "1.2.0")),
        .package(
            url: "https://github.com/apple/swift-numerics",
            .upToNextMajor(from: "1.0.2")),
    ],
    targets: [
        .executableTarget(
            name: "Genpass",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "PasswordGenerators",
            ],
            resources: [
                .embedInCode("Subcommands/english.txt"),
            ]),
        .target(
            name: "PasswordGenerators",
            dependencies: [
                .product(name: "Algorithms", package: "swift-algorithms"),
                .product(name: "Numerics", package: "swift-numerics"),
            ]),
    ]
)
