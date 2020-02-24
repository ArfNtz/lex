// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "lex",
    products: [
        .library( name: "lex", targets: ["lex"]),
        .executable(name: "example", targets: ["example"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "lex",
            dependencies: []),
        .testTarget(
            name: "lexTests",
            dependencies: ["lex"]),
        .target(
            name: "example",
            dependencies: ["lex"]),
    ]
)
