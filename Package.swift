// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MdlPEGParser",
    dependencies: [
        .package(name: "SwiftPEG", url: "https://github.com/zhuzilin/SwiftPEG.git", from: "0.1.0"),
        .package(name: "LLVM", url: "https://github.com/llvm-swift/LLVMSwift.git", from: "0.8.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "MdlPEGParser",
            dependencies: ["SwiftPEG", "LLVM"]),
        .testTarget(
            name: "MdlPEGParserTests",
            dependencies: ["MdlPEGParser"]),
    ]
)
