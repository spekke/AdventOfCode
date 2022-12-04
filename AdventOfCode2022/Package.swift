// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AdventOfCode2022",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .executable(
            name: "Day1",
            targets: ["Day1"]
        ),
        .executable(
            name: "Day2",
            targets: ["Day2"]
        ),
        .executable(
            name: "Day3",
            targets: ["Day3"]
        ),
        .executable(
            name: "Day4",
            targets: ["Day4"]
        )
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
        .executableTarget(
            name: "Day2",
            dependencies: [],
            resources: [
                .copy("input.txt")
            ]
        ),
        .executableTarget(
            name: "Day3",
            dependencies: [],
            resources: [
                .copy("input.txt")
            ]
        ),
        .executableTarget(
            name: "Day4",
            dependencies: [],
            resources: [
                .copy("input.txt")
            ]
        )
    ]
)
