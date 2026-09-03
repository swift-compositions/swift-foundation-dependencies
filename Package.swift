// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-foundation-dependencies",
    platforms: [
        .iOS(.v27),
        .macOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
    ],
    products: [
        .library(name: "Foundation Dependencies", targets: ["Foundation Dependencies"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-molecules/swift-foundation-extensions.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-compositions/swift-dependencies.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Foundation Dependencies",
            dependencies: [
                .product(name: "Foundation Date Extensions", package: "swift-foundation-extensions"),
                .product(name: "Dependencies", package: "swift-dependencies"),
            ]
        ),
        .testTarget(
            name: "Foundation Dependencies Tests",
            dependencies: [
                .target(name: "Foundation Dependencies"),
                .product(name: "Dependencies Test Support", package: "swift-dependencies"),
            ]
        ),
    ]
)

