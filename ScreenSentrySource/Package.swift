// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ScreenSentrySource",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "AppUI",
            targets: ["AppUI"]),
        .library(
            name: "Home",
            targets: ["Home"]),
    ],
    targets: [
        .target(
            name: "AppUI",
            resources: [
                .process("Assets")
            ]),
        .target(
            name: "Home",
            dependencies: [.target(name: "AppUI")]),
    ]
)
