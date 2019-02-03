// swift-tools-version:4.2
import PackageDescription

let package = Package(
  name: "Eigen",
  dependencies: [
    .package(url: "https://github.com/Realm/SwiftLint", from: "0.30.1"),
    ],
  targets: [
    .target(name: "eigen", path: "Sources/Container", sources: ["Container.swift"]),
    ]
)

//// The settings for the git hooks for our repo
//#if canImport(PackageConfig)
//import PackageConfig
//
//let config = PackageConfig([
//  "komondor": [
//    // When someone has run `git commit`, first run
//    // run SwiftFormat and the auto-correcter for SwiftLint
//    "pre-commit": [
//      "swift run swiftformat .",
//      "swift run swiftlint autocorrect --path Artsy/",
//      "git add .",
//    ],
//  ]
//  ])
//#endif
