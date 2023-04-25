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
            name: "AddPaymentMethodImp",
            targets: ["AddPaymentMethodImp"]),
        .library(
            name: "AddPaymentMethodTestSupport",
            targets: ["AddPaymentMethodTestSupport"]),
        .library(
            name: "Topup",
            targets: ["Topup"]),
        .library(
            name: "TopupImp",
            targets: ["TopupImp"]),
        .library(
            name: "TopupTestSupport",
            targets: ["TopupTestSupport"]),
        .library(
            name: "FinanceHome",
            targets: ["FinanceHome"]),
        .library(
            name: "FinanceEntity",
            targets: ["FinanceEntity"]),
        .library(
            name: "FinanceRepository",
            targets: ["FinanceRepository"]),
        .library(
            name: "FinanceRepositoryTestSupport",
            targets: ["FinanceRepositoryTestSupport"]),
    ],
    
    dependencies: [
        .package(name: "ModernRIBs",url: "https://github.com/DevYeom/ModernRIBs", .exact("1.0.1")),
        .package(url: "https://github.com/CombineCommunity/CombineExt", from: "1.0.0"),
        .package(path: "../Platform"),
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.10.0"),
    ],
    
    targets: [
        .target(
            name: "AddPaymentMethod",
            dependencies: [
                "FinanceEntity",
                "ModernRIBs",
                .product(name: "RIBsUtil", package: "Platform")
            ]
        ),
        .target(
            name: "AddPaymentMethodImp",
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
            name: "AddPaymentMethodTestSupport",
            dependencies: [
                "AddPaymentMethod",
                "FinanceEntity",
                "FinanceRepository",
                "ModernRIBs",
                .product(name: "RIBsUtil", package: "Platform"),
                .product(name: "SuperUI", package: "Platform"),
                .product(name: "RIBsTestSupport", package: "Platform")
            ]
        ),
        .target(
            name: "Topup",
            dependencies: [
                "ModernRIBs"
            ]
        ),
        .target(
            name: "TopupImp",
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
            name: "TopupTestSupport",
            dependencies: [
                "Topup"
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
                .product(name: "CombineUtil", package: "Platform"),
                .product(name: "Network", package: "Platform")
            ]
        ),
        .target(
            name: "FinanceRepositoryTestSupport",
            dependencies: [
                "FinanceEntity",
                "FinanceRepository",
                .product(name: "CombineUtil", package: "Platform"),
                .product(name: "Network", package: "Platform")
            ]
        ),
        
        .testTarget(
            name: "TopupImpTests",
            dependencies: [
                "ModernRIBs",
                "TopupImp",
                "Topup",
                "TopupTestSupport",
                "FinanceEntity",
                "FinanceRepository",
                "FinanceRepositoryTestSupport",
                "AddPaymentMethodTestSupport",
                .product(name: "CombineUtil", package: "Platform"),
                .product(name: "RIBsUtil", package: "Platform"),
                .product(name: "SuperUI", package: "Platform"),
                .product(name: "RIBsTestSupport", package: "Platform"),
                .product(name: "PlatformTestSupport", package: "Platform"),
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing")
            ],
            exclude: [
                "EnterAmount/__Snapshots__",
                "CardOnFile/__Snapshots__"
            ]
        )
    ]
)
