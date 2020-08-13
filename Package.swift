// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "Changelog",
    platforms: [
        .macOS(.v10_13),
    ],
    products: [
        .library(name: "ChangelogCore", targets: ["ChangelogCore"]),
        .executable(name: "Changelog", targets: ["Changelog"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", .upToNextMajor(from: "0.0.6")),
    ],
    targets: [
        .target(
            name: "Changelog",
            dependencies: ["ChangelogCore"]),
        .target(
            name: "ChangelogCore",
            dependencies: [.product(name: "ArgumentParser", package: "swift-argument-parser")]),
        .testTarget(
            name: "ChangelogCoreTests",
            dependencies: ["ChangelogCore"]),
    ]
)
