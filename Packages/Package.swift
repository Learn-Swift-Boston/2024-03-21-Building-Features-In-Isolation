// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Packages",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        .library(
            name: "AppFeature",
            targets: [
                "AppFeature",
            ]
        ),
        .library(
            name: "AuthFeature",
            targets: [
                "AuthFeature",
            ]
        ),
    ],
    targets: [
        .target(
            name: "AppFeature",
            dependencies: [
                "AuthFeature",
            ]
        ),
        .target(
            name: "AuthFeature"
        ),
    ]
)
