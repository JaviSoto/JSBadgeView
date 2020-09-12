// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "JSBadgeView",
    products: [
        .library(name: "JSBadgeView", targets: ["JSBadgeView"])
    ],
    targets: [
        .target(name: "JSBadgeView", path: "Pod/Classes", publicHeadersPath: "", cSettings: [.headerSearchPath("")])
    ]
)
