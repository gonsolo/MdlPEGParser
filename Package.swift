// swift-tools-version:6.0.2

import PackageDescription

let package = Package(
  name: "MdlPegParser",
  dependencies: [
    .package(url: "https://github.com/zhuzilin/SwiftPEG.git", from: "0.1.0"),
    .package(url: "https://github.com/gonsolo/LLVMSwift.git", branch: "gonsolo"),
  ],
  targets: [
    .executableTarget(
      name: "MdlPegParser",
      dependencies: [
        "SwiftPEG",
        .product(name: "LLVM", package: "llvmswift"),
      ]),
    .testTarget(
      name: "MdlPegParserTests",
      dependencies: ["MdlPegParser"]),
  ],
  swiftLanguageModes: [.v5],
  cxxLanguageStandard: .cxx20
)
