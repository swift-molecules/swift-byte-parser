// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-byte-parser-primitives",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "Byte Parser Primitives",
            targets: ["Byte Parser Primitives"]
        ),
        .library(
            name: "Byte Parser Primitives Test Support",
            targets: ["Byte Parser Primitives Test Support"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-primitives/swift-parser-primitives.git",
            branch: "main"
        ),

        .package(
            url: "https://github.com/swift-primitives/swift-byte-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-either-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-input-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-array-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-column-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-ownership-shared-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-buffer-linear-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-storage-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-memory-heap-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-memory-allocation-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-cursor-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-memory-cursor-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-index-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-collection-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-span-primitives.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Byte Parser Primitives",
            dependencies: [
                .product(name: "Parser Primitives", package: "swift-parser-primitives"),
                .product(name: "Parser Match Primitives", package: "swift-parser-primitives"),
                .product(name: "Parser EndOfInput Primitives", package: "swift-parser-primitives"),
                .product(name: "Parser Take Primitives", package: "swift-parser-primitives"),
                .product(name: "Byte Primitives", package: "swift-byte-primitives"),
                .product(
                    name: "Byte Primitives Standard Library Integration",
                    package: "swift-byte-primitives"
                ),
                .product(name: "Either Primitives", package: "swift-either-primitives"),
                .product(name: "Input Primitives", package: "swift-input-primitives"),
                .product(name: "Array Primitives", package: "swift-array-primitives"),

                .product(name: "Array Primitive", package: "swift-array-primitives"),

                .product(name: "Column Primitives", package: "swift-column-primitives"),
                .product(
                    name: "Ownership Shared Primitive",
                    package: "swift-ownership-shared-primitives"
                ),
                .product(
                    name: "Buffer Linear Primitive",
                    package: "swift-buffer-linear-primitives"
                ),
                .product(
                    name: "Buffer Linear Primitives",
                    package: "swift-buffer-linear-primitives"
                ),
                .product(
                    name: "Storage Contiguous Primitives",
                    package: "swift-storage-primitives"
                ),
                .product(name: "Memory Heap Primitives", package: "swift-memory-heap-primitives"),

                .product(
                    name: "Memory Allocator Primitive",
                    package: "swift-memory-allocation-primitives"
                ),
                .product(name: "Cursor Primitives", package: "swift-cursor-primitives"),
                .product(name: "Cursor Primitive", package: "swift-cursor-primitives"),
                .product(
                    name: "Memory Cursor Primitives",
                    package: "swift-memory-cursor-primitives"
                ),
                .product(name: "Index Primitives", package: "swift-index-primitives"),
                .product(name: "Collection Primitives", package: "swift-collection-primitives"),

                .product(name: "Span Protocol Primitives", package: "swift-span-primitives"),
            ]
        ),
        .target(
            name: "Byte Parser Primitives Test Support",
            dependencies: [
                "Byte Parser Primitives",
                .product(name: "Byte Primitives Test Support", package: "swift-byte-primitives"),
                .product(name: "Input Primitives", package: "swift-input-primitives"),
                .product(name: "Index Primitives Test Support", package: "swift-index-primitives"),
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Byte Parser Primitives Tests",
            dependencies: [
                "Byte Parser Primitives",
                "Byte Parser Primitives Test Support",
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
