// swift-tools-version: 6.3

import PackageDescription

let commonSwiftSettings: [SwiftSetting] = [
    .enableExperimentalFeature("Lifetimes"),
    .enableExperimentalFeature("LifetimeDependence"),
    .enableUpcomingFeature("InternalImportsByDefault"),
    .enableUpcomingFeature("MemberImportVisibility"),
    .strictMemorySafety(),
]

let package = Package(
    name: "genpass-swift",
    platforms: [
        .macOS(.v15)
    ],
    products: [
        .executable(
            name: "genpass",
            targets: ["Genpass"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-algorithms.git",
            from: "1.2.0"),
        .package(
            url: "https://github.com/apple/swift-argument-parser.git",
            from: "1.5.0"),
        .package(
            url: "https://github.com/apple/swift-collections.git",
            from: "1.1.0"),
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
                .embedInCode("Subcommands/english.txt")
            ],
            swiftSettings: commonSwiftSettings),
        .target(
            name: "PasswordGenerators",
            dependencies: [
                .product(name: "Algorithms", package: "swift-algorithms"),
                .product(name: "OrderedCollections", package: "swift-collections"),
            ],
            swiftSettings: commonSwiftSettings),
    ]
)
