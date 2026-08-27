// swift-tools-version: 6.4

import PackageDescription

extension String {
    static let foundationDependencies: Self = "Foundation Dependencies"
}

extension Target.Dependency {
    static var foundationDateExtensions: Self {
        .product(name: "Foundation Date Extensions", package: "swift-foundation-extensions")
    }
    static var dependencies: Self { .product(name: "Dependencies", package: "swift-dependencies") }
    static var dependenciesTestSupport: Self {
        .product(name: "Dependencies Test Support", package: "swift-dependencies")
    }
    static var foundationDependencies: Self { .target(name: .foundationDependencies) }
}

let package = Package(
    name: "swift-foundation-dependencies",
    platforms: [
        .iOS(.v27),
        .macOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
    ],
    products: [
        .library(name: .foundationDependencies, targets: [.foundationDependencies])
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
            name: .foundationDependencies,
            dependencies: [
                .foundationDateExtensions,
                .dependencies,
            ]
        ),
        .testTarget(
            name: .foundationDependencies.tests,
            dependencies: [
                .foundationDependencies,
                .dependenciesTestSupport,
            ]
        ),
    ]
)

extension String { var tests: Self { self + " Tests" } }
