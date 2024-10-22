// swift-tools-version:5.2

import PackageDescription

let cglmBuildSettings: [CSetting] = [
    .define("CGLM_CLIPSPACE_INCLUDE_ALL‎")
    ]

let package = Package(
    name: "cglm",
    products: [
        .library(name: "cglm", type: .static, targets: ["cglmHeader"]),
        .library(name: "cglmc", targets: ["cglmCompiled"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "cglmCompiled",
            path: "./",
            exclude: [
                "./docs",
                "./src/swift",
                "./include",
                "./test",
                "./win",
            ],
            sources: [
                "./src",
            ],
            publicHeadersPath: "./include"
        ),
        .target(
            name: "cglmHeader",
            path: "./",
            exclude: [
                "./docs",
                "./include",
                "./test",
                "./win",
            ],
            sources: [
                "./src/swift",
            ],
            publicHeadersPath: "./include",
            cSettings: cglmBuildSettings
        ),
    ],
    cLanguageStandard: .c11
)
