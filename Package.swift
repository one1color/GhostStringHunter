// swift-tools-version:5.3
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
        .executable(
            name: "Ghoststringhunter",
            targets: ["GhostStringHunter"]),
    ],
    dependencies: [
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
