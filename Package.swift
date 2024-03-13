// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Slingshot",
    platforms: [.macOS(.v13), .iOS(.v16)],
    products: [
        .library(
            name: "Slingshot",
            targets: ["Slingshot"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Nimble.git", from: "9.2.1"),
        .package(url: "https://github.com/Quick/Quick.git", from: "4.0.0"),
        .package(url: "https://github.com/jpsim/Yams.git", from: "5.0.6"),
    ],
    targets: [
        .target(name: "Slingshot", plugins: [.plugin(name: "SlingshotPlugin")]),
        .plugin(name: "SlingshotPlugin", capability: .buildTool, dependencies: ["SlingshotCodeGeneration"]),
        .executableTarget(name: "SlingshotCodeGeneration", 
                          dependencies: ["Yams"],
                          resources: [.copy("Resources")]),
        .testTarget(
            name: "SlingshotTests",
            dependencies: ["Slingshot",
                           .product(name: "Nimble", package: "Nimble"),
                           .product(name: "Quick", package: "Quick")],
            path: "Tests"),
    ]
)
