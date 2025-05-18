// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "AzureStorageSwift",
    platforms: [
        .macOS(.v13), .iOS(.v14)
    ],
    products: [
        .library(
            name: "AzureStorageSwift",
            targets: ["AzureStorageSwift"]),
    ],
    targets: [
        .target(
            name: "AzureStorageSwift",
            dependencies: [],
            path: "Sources/AzureStorageSwift",
            exclude: [],
            publicHeadersPath: "include",
            cSettings: [
                .headerSearchPath("."),
                .headerSearchPath("include")
                
            ]
        ),
        .testTarget(
            name: "AzureStorageSwiftTests",
            dependencies: ["AzureStorageSwift"],
            path: "Tests/AzureStorageSwiftTests"
        ),
    ]
)
