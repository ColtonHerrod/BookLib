// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "BookLib",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "BookLib",
            targets: ["BookLib"]),
    ],
    dependencies: [
        // Add dependencies here
      .package(url: "https://github.com/tadija/AEXML.git", branch: "master"),
      .package(url: "https://github.com/ColtonHerrod/EPUBKit.git", .upToNextMajor(from: "0.4.0")),
    
    ],
    targets: [
        .target(
            name: "BookLib",
            dependencies: [
                .product(name: "AEXML", package: "AEXML"),
                .product(name: "EPUBKit", package: "EPUBKit"),
            ]),
    ]
)