// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "platform",
    products: [
        .executable(name: "platform", targets: ["ZPAutomator"])
    ],
    dependencies: [
        .package(name: "ShellOut", url: "https://github.com/johnsundell/shellout.git", from: "2.3.0"),
        .package(name: "SwiftProtobuf", url: "https://github.com/apple/swift-protobuf", from: "1.15.0"),
     ],
    targets: [
        .target(
            name: "ZPAutomator",
            dependencies: ["ShellOut" , "SwiftProtobuf"]
        ),
        .testTarget(
            name: "ZPAutomatorTests",
            dependencies: ["ZPAutomator"]),
    ]
)
