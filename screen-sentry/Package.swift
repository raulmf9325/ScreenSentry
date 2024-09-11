// swift-tools-version:5.10

import PackageDescription

let package = Package(
    name: "screen-sentry",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(name: "AppCore", targets: ["AppCore"]),
        .library(name: "AppUI", targets: ["AppUI"]),
        .library(name: "Home", targets: ["Home"]),
        .library(name: "AdultContent", targets: ["AdultContent"]),
        .library(name: "StartBlockingSession", targets: ["StartBlockingSession"]),
        .library(name: "ScreenTimeAPI", targets: ["ScreenTimeAPI"]),
        .library(name: "ScreenTimeApiLive", targets: ["ScreenTimeApiLive"]),
        .library(name: "LocalNotificationsAPI", targets: ["LocalNotificationsAPI"]),
        .library(name: "LocalNotificationsApiLive", targets: ["LocalNotificationsApiLive"]),
        .library(name: "CountdownTimer", targets: ["CountdownTimer"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.12.1"),
        .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.3.6"),
    ],
    targets: [
        .target(
            name: "AppCore",
            dependencies: [
                "Home",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]),
        .target(
            name: "Home",
            dependencies: [
                "StartBlockingSession",
                "AdultContent",
                "AppUI",
                "ScreenTimeAPI",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]),
        .target(
            name: "AdultContent",
            dependencies: [
                "AppUI",
                "ScreenTimeAPI",
                "LocalNotificationsAPI",
                "CountdownTimer",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]),
        .target(
            name: "StartBlockingSession",
            dependencies: [
                "AppUI",
                "ScreenTimeAPI",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]),
        .target(
            name: "AppUI"),
        .target(
            name: "ScreenTimeAPI",
            dependencies: [
                .product(name: "Dependencies", package: "swift-dependencies"),
                .product(name: "DependenciesMacros", package: "swift-dependencies"),
            ]
        ),
        .target(
            name: "ScreenTimeApiLive",
            dependencies: [
                "ScreenTimeAPI",
                .product(name: "Dependencies", package: "swift-dependencies")
            ]),
        .target(
            name: "LocalNotificationsAPI",
            dependencies: [
                .product(name: "Dependencies", package: "swift-dependencies"),
                .product(name: "DependenciesMacros", package: "swift-dependencies"),
            ]
        ),
        .target(
            name: "LocalNotificationsApiLive",
            dependencies: [
                "LocalNotificationsAPI",
                .product(name: "Dependencies", package: "swift-dependencies")
            ]),
        .target(
            name: "CountdownTimer",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
    ]
)
