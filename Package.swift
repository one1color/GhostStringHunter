// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "GhostStringHunter",
    products: [
        .library(
            name: "GhostStringHunter",
            targets: ["GhostStringHunter"]),
        .executable(
            name: "GhostStringHunterExecutable",
            targets: ["GhostStringHunterExecutable"])
    ],
    dependencies: [
        // Add any dependencies here
    ],
    targets: [
        .target(
            name: "GhostStringHunter",
            dependencies: []),
        .target(
            name: "GhostStringHunterExecutable",
            dependencies: ["GhostStringHunter"])
    ]
)
