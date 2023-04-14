// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "GhostStringHunter",
    platforms: [
        .iOS(.v11),
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "GhostStringHunter",
            targets: ["GhostStringHunter"]),
        .executable(
            name: "ghoststringhunter-buildtool",
            targets: ["GhostStringHunterBuildTool"]),
    ],
    dependencies: [
        // Add any dependencies here
    ],
    targets: [
        .target(
            name: "GhostStringHunter",
            dependencies: []),
        .executableTarget(
            name: "GhostStringHunterBuildTool",
            dependencies: ["GhostStringHunter"]),
        .testTarget(
            name: "GhostStringHunterTests",
            dependencies: ["GhostStringHunter"]),
    ]
)

