// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "GhostStringHunter",
    platforms: [
        .macOS(.v11),
    ],
    products: [
        .library(
            name: "GhostStringHunter",
            targets: ["GhostStringHunter"]),
    ],
    dependencies: [
    ],
    targets: [
        .executableTarget(
            name: "GhostStringHunterCLI",
            dependencies: ["GhostStringHunter"]),
        .target(
            name: "GhostStringHunter",
            dependencies: []),
        .testTarget(
            name: "GhostStringHunterTests",
            dependencies: ["GhostStringHunter"]),
    ]
)
