// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AdventOfCode2022",
    platforms: [
        .macOS(.v12)
    ],
    dependencies: [],
    targets: [
        .executableTarget(
            name: "Day1",
            dependencies: [],
            resources: [
                .copy("input.txt")
            ]
        ),
        .testTarget(
            name: "Day1Tests",
            dependencies: ["Day1"]
        )
    ]
)
