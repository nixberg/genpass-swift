// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "genpass-swift",
    products: [
        .executable(name: "genpass", targets: ["Genpass"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.3.0"),
    ],
    targets: [
        .target(
            name: "Genpass",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]
        )
    ]
)
