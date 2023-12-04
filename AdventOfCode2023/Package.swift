// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AdventOfCode2023",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .executable(
            name: "Day1",
            targets: ["Day1"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-parsing", from: "0.13.0")
    ],
    targets: [
        .executableTarget(
            name: "Day1",
            dependencies: [
                .product(name: "Parsing", package: "swift-parsing")
            ],
            resources: [
                .copy("input.txt")
            ]
        )
    ]
)
