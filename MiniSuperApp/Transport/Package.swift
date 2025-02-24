// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Transport",
    platforms: [.iOS(.v14)],
    
    products: [
        .library(
            name: "TransportHome",
            targets: ["TransportHome"]),
        .library(
            name: "TransportHomeImp",
            targets: ["TransportHomeImp"]),
    ],
    
    dependencies: [
        .package(name: "ModernRIBs", url: "https://github.com/DevYeom/ModernRIBs", .exact("1.0.1")),
        .package(path: "../Platform"),
        .package(path: "../Finance"),
    ],
    
    targets: [
        .target(
            name: "TransportHome",
            dependencies: [
                "ModernRIBs",
               
            ]
        ),
        .target(
            name: "TransportHomeImp",
            dependencies: [
                "ModernRIBs",
                "TransportHome",
                .product(name: "RIBsUtil", package: "Platform"),
                .product(name: "SuperUI", package: "Platform"),
                .product(name: "FinanceRepository", package: "Finance"),
                .product(name: "Topup", package: "Finance"),
            ],
            resources: [
                .process("Resources")
            ]
        ),
    ]
)
