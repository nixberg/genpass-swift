// swift-tools-version:5.4

import PackageDescription

let package = Package(
    name: "genpass-swift",
    products: [
        .executable(name: "genpass", targets: ["Genpass"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.5.0"),
    ],
    targets: [
        .executableTarget(
            name: "Genpass",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]),
    ]
)
