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
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.10.4"),
    ],
    targets: [
        .target(
            name: "AppCore",
            dependencies: [
                "Home",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]),
        .target(
            name: "AppUI"),
        .target(
            name: "Home",
            dependencies: [
                "AppUI",
            ]),
    ]
)

for target in package.targets {
  target.swiftSettings = [
    .unsafeFlags([
      "-Xfrontend", "-enable-actor-data-race-checks",
      "-Xfrontend", "-warn-concurrency",
    ])
  ]
}
