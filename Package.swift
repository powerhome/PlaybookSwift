// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
  name: "Playbook",
  platforms: [
    .macOS(.v14),
    .iOS(.v17)
  ],
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.
    .library(
      name: "Playbook",
      targets: ["Playbook"])
  ],
  dependencies: [
    // Dependencies declare other packages that this package depends on.
    .package(url: "https://github.com/marmelroy/PhoneNumberKit.git", from: "3.8.0"),
    .package(url: "git@github.com:powerhome/power-fonts.git", from: "0.0.1"),
    .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.17.7")
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .target(
      name: "Playbook",
      dependencies: [
        .product(name: "PhoneNumberKit", package: "PhoneNumberKit"),
        .product(name: "power-fonts", package: "power-fonts")
      ],
      resources: [.process("Resources/Assets/")]
    ),
    .testTarget(
      name: "SnapshotTests",
      dependencies: [
        "Playbook",
        .product(name: "SnapshotTesting", package: "swift-snapshot-testing")
      ]
    )
  ]
)
