// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "genpass-swift",
    products: [
        .executable(name: "genpass", targets: ["Genpass"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.0"),
    ],
    targets: [
        .executableTarget(
            name: "Genpass",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]),
    ]
)
