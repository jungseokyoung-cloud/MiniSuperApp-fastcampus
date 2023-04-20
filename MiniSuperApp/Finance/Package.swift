// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Finance",
    platforms: [.iOS(.v14)],
    
    products: [
        .library(
            name: "AddPaymentMethod",
            targets: ["AddPaymentMethod"]),
        .library(
            name: "Topup",
            targets: ["Topup"]),
        .library(
            name: "FinanceHome",
            targets: ["FinanceHome"]),
        .library(
            name: "FinanceEntity",
            targets: ["FinanceEntity"]),
        .library(
            name: "FinanceRepository",
            targets: ["FinanceRepository"]),

    ],
    
    dependencies: [
        .package(name: "ModernRIBs",url: "https://github.com/DevYeom/ModernRIBs", .exact("1.0.1")),
        .package(url: "https://github.com/CombineCommunity/CombineExt", from: "1.0.0"),
        .package(path: "../Platform"),
    ],
    
    targets: [
        .target(
            name: "AddPaymentMethod",
            dependencies: [
                "FinanceEntity",
                "FinanceRepository",
                "ModernRIBs",
                .product(name: "RIBsUtil", package: "Platform"),
                .product(name: "SuperUI", package: "Platform")

            ]
        ),
        .target(
            name: "Topup",
            dependencies: [
                "AddPaymentMethod",
                "FinanceEntity",
                "FinanceRepository",
                "ModernRIBs",
                .product(name: "RIBsUtil", package: "Platform"),
                .product(name: "SuperUI", package: "Platform")
            ]
        ),
        .target(
            name: "FinanceHome",
            dependencies: [
                "AddPaymentMethod",
                "Topup",
                "FinanceEntity",
                "FinanceRepository",
                "ModernRIBs",
                .product(name: "RIBsUtil", package: "Platform"),
                .product(name: "SuperUI", package: "Platform")
            ]
        ),
        .target(
            name: "FinanceEntity",
            dependencies: []
        ),
        .target(
            name: "FinanceRepository",
            dependencies: [
                "CombineExt",
                "FinanceEntity",
                .product(name: "CombineUtil", package: "Platform")
            ]
        ),

       
    ]
)
