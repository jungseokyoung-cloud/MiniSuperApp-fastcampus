// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Platform",
    platforms: [.iOS(.v14)],
    
    products: [
        .library(
            name: "RIBsUtil",
            targets: ["RIBsUtil"]),
        .library(
            name: "RIBsTestSupport",
            targets: ["RIBsTestSupport"]),
        .library(
            name: "PlatformTestSupport",
            targets: ["PlatformTestSupport"]),
        .library(
            name: "CombineUtil",
            targets: ["CombineUtil"]),
        .library(
            name: "SuperUI",
            targets: ["SuperUI"]),
        .library(
            name: "DefaultsStore",
            targets: ["DefaultsStore"]),
        .library(
            name: "Network",
            targets: ["Network"]),
        .library(
            name: "NetworkImp",
            targets: ["NetworkImp"]),
    ],
    
    dependencies: [
        .package(url: "https://github.com/CombineCommunity/CombineExt", from: "1.0.0"),
        .package(url: "https://github.com/DevYeom/ModernRIBs", exact: "1.0.1"),
        .package(url: "https://github.com/pointfreeco/combine-schedulers", from: "0.9.1"),
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.10.0"),
        .package(name: "Swifter", url: "https://github.com/httpswift/swifter", .upToNextMajor(from: "1.5.0"))
    ],
    
    targets: [
        .target(
            name: "RIBsUtil",
            dependencies: [
                "ModernRIBs"
            ]
        ),
        .target(
            name: "RIBsTestSupport",
            dependencies: [
                "ModernRIBs"
            ]
        ),
        .target(
            name: "PlatformTestSupport",
            dependencies: [
                "ModernRIBs",
                "Swifter",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
            ]
        ),
        .target(
            name: "CombineUtil",
            dependencies: [
                "CombineExt",
                .product(name: "CombineSchedulers", package: "combine-schedulers")
            ]
        ),
        .target(
            name: "SuperUI",
            dependencies: [
                "RIBsUtil",
            ]
        ),
        .target(
            name: "DefaultsStore",
            dependencies: []
        ),
        .target(
            name: "Network",
            dependencies: []
        ),
        .target(
            name: "NetworkImp",
            dependencies: [
                "Network",
            ]
        ),
    ]
)
