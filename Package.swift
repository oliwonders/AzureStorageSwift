// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AzureStorageSwift",
    platforms: [
        .macOS(.v11), .iOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "AzureStorageSwift",
            targets: ["AzureStorageSwift"]),
    ],
    targets: [
        .target(
            name: "AzureStorageSwift",
            dependencies: [],
            path: "Sources/AzureStorageSwift",
            exclude: ["include"], // Prevents double imports
            publicHeadersPath: "include",
            cSettings: [
                .headerSearchPath("Sources/AzureStorageSwift/include"),
            ]
        ),
        .testTarget(
            name: "AzureStorageSwiftTests",
            dependencies: ["AzureStorageSwift"],
            path: "Tests/AzureStorageSwiftTests"
        ),
    ]
)
