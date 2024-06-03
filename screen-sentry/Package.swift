// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "screen-sentry",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "AppCore", targets: ["AppCore"]),
        .library(name: "AppUI", targets: ["AppUI"]),
        .library(name: "Home", targets: ["Home"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", exact: "1.0.0"),
    ],
    targets: [
        .target(
            name: "AppUI"),
        .target(
            name: "Home",
            dependencies: [
                "AppUI",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]),
        .target(
            name: "AppCore",
            dependencies: [
                "Home",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]),
    ]
)
