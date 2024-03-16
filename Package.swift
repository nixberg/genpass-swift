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
            from: "1.3.1"),
        .package(
            url: "https://github.com/apple/swift-collections",
            from: "1.0.6"),
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
            ],
            swiftSettings: .allUpcomingFeatures),
        .target(
            name: "PasswordGenerators",
            dependencies: [
                .product(name: "Algorithms", package: "swift-algorithms"),
                .product(name: "Numerics", package: "swift-numerics"),
                .product(name: "OrderedCollections", package: "swift-collections"),
            ],
            swiftSettings: .allUpcomingFeatures),
    ]
)

extension [SwiftSetting] {
    // As of 2024-03-13: https://www.swift.org/swift-evolution/#?upcoming=true
    static var allUpcomingFeatures: Self {
        [
            .enableExperimentalFeature("StrictConcurrency"),
            .enableUpcomingFeature("StrictConcurrency"),
            
            .enableUpcomingFeature("FullTypedThrows"),
            .enableUpcomingFeature("InternalImportsByDefault"),
            .enableUpcomingFeature("InferSendableFromCaptures"),
            .enableUpcomingFeature("IsolatedDefaultValues"),
            .enableUpcomingFeature("DisableOutwardActorInference"),
            .enableUpcomingFeature("ImportObjcForwardDeclarations"),
            .enableUpcomingFeature("DeprecateApplicationMain"),
            .enableUpcomingFeature("BareSlashRegexLiterals"),
            .enableUpcomingFeature("ExistentialAny"),
            .enableUpcomingFeature("ForwardTrailingClosures"),
            .enableUpcomingFeature("ConciseMagicFile"),
        ]
    }
}
