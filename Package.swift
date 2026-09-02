// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-byte-parser",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "Byte Parser",
            targets: ["Byte Parser"]
        ),
        .library(
            name: "Byte Parser Test Support",
            targets: ["Byte Parser Test Support"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-atoms/swift-parser.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-byte.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-either.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-cursor.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-checkpoint.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-iterator.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-cursor-parser.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-collection.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Byte Parser",
            dependencies: [
                .product(name: "Parser", package: "swift-parser"),
                .product(name: "Byte", package: "swift-byte"),
                .product(name: "Either", package: "swift-either"),
                .product(name: "Checkpoint", package: "swift-checkpoint"),
                .product(name: "Cursor", package: "swift-cursor"),
                .product(name: "Cursor Parser First", package: "swift-cursor-parser"),
                .product(name: "Iterator", package: "swift-iterator"),
                .product(name: "Iterator Protocol", package: "swift-iterator"),
                .product(name: "Collection", package: "swift-collection"),
            ]
        ),
        .target(
            name: "Byte Parser Test Support",
            dependencies: [
                "Byte Parser",
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Byte Parser Tests",
            dependencies: [
                "Byte Parser",
                "Byte Parser Test Support",
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
