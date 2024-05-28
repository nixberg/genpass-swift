// swift-tools-version:5.10

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
            url: "https://github.com/apple/swift-algorithms",
            from: "1.2.0"),
        .package(
            url: "https://github.com/apple/swift-argument-parser",
            from: "1.4.0"),
        .package(
            url: "https://github.com/apple/swift-collections",
            from: "1.1.0"),
        .package(
            url: "https://github.com/apple/swift-numerics",
            from: "1.0.2"),
    ],
    targets: [
        .executableTarget(
            name: "Genpass",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "OrderedCollections", package: "swift-collections"),
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
                .product(name: "OrderedCollections", package: "swift-collections"),
            ]),
    ]
)
