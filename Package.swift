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
            url: "https://github.com/swift-molecules/swift-parser.git",
            branch: "main"
        ),

        .package(
            url: "https://github.com/swift-molecules/swift-byte.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-either.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-input.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-array.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-column.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-ownership-shared.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-buffer-linear.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-storage.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-memory-heap.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-memory-allocation.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-cursor.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-memory-cursor.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-index.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-collection.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-span.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Byte Parser",
            dependencies: [
                .product(name: "Parser", package: "swift-parser"),
                .product(name: "Parser Match", package: "swift-parser"),
                .product(name: "Parser EndOfInput", package: "swift-parser"),
                .product(name: "Parser Take", package: "swift-parser"),
                .product(name: "Byte", package: "swift-byte"),
                .product(
                    name: "Byte Standard Library Integration",
                    package: "swift-byte"
                ),
                .product(name: "Either", package: "swift-either"),
                .product(name: "Input", package: "swift-input"),
                .product(name: "Array", package: "swift-array"),

                .product(name: "Array Primitive", package: "swift-array"),

                .product(name: "Column", package: "swift-column"),
                .product(
                    name: "Ownership Shared Primitive",
                    package: "swift-ownership-shared"
                ),
                .product(
                    name: "Buffer Linear Primitive",
                    package: "swift-buffer-linear"
                ),
                .product(
                    name: "Buffer Linear",
                    package: "swift-buffer-linear"
                ),
                .product(
                    name: "Storage Contiguous",
                    package: "swift-storage"
                ),
                .product(name: "Memory Heap", package: "swift-memory-heap"),

                .product(
                    name: "Memory Allocator Primitive",
                    package: "swift-memory-allocation"
                ),
                .product(name: "Cursor", package: "swift-cursor"),
                .product(name: "Cursor Primitive", package: "swift-cursor"),
                .product(
                    name: "Memory Cursor",
                    package: "swift-memory-cursor"
                ),
                .product(name: "Index", package: "swift-index"),
                .product(name: "Collection", package: "swift-collection"),

                .product(name: "Span Protocol", package: "swift-span"),
            ]
        ),
        .target(
            name: "Byte Parser Test Support",
            dependencies: [
                "Byte Parser",
                .product(name: "Byte Test Support", package: "swift-byte"),
                .product(name: "Input", package: "swift-input"),
                .product(name: "Index Test Support", package: "swift-index"),
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
