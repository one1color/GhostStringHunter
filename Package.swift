// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GhostStringHunter",
    platforms: [
        .iOS(.v12),
        .macOS(.v11)
    ],
    products: [
        .library(
            name: "GhostStringHunter",
            targets: ["GhostStringHunter"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
    ],
    targets: [
        .target(
            name: "GhostStringHunter",
            dependencies: []),
        .testTarget(
            name: "GhostStringHunterTests",
            dependencies: ["GhostStringHunter"]),
    ]
)
