// swift-tools-version:5.2

import PackageDescription

var cglmBuildSettings: [CSetting] = [
    .headerSearchPath("./"),
    .define("CGLM_CLIPSPACE_INCLUDE_ALL")
    ]

#if arch(x86_64)
cglmBuildSettings += [.define("__AVX__")]
#elseif arch(arm64) && os(Windows)
cglmBuildSettings += [.define("_M_ARM64")]
#elseif arch(arm64) && os(Linux) || os(macOS) || os(iOS)
cglmBuildSettings += [.define("__ARM_NEON")]
#endif

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
            publicHeadersPath: "./include",
            cSettings: cglmBuildSettings
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
