

import TuistExtension
import ProjectDescription

let name: String = Project.appName
let defaultKnownRegions = ["ko", "en", "ja"]

let AppTargets: [Target] = Project.createAppTarget(
    name: name,
    destinations: .iOS,
    product: .app,
    bundleId: "$(APP_IDENTIFIER)",
    deploymentTargets: Project.deployTarget,
    plistFolderName: name,
    plistFileName: "Info",
    entitlementFolderName: name,
    entitlementName: "Sample",
    sources: ["Sources/App/**"],
    testSource: ["Tests/App/**"],
    targetScripts: [
        .pre(
            script: """
            echo "hello world"
            """,
            name: "Sample"
        )
    ],
    dependencies: [
        .target(name: "Data"),
        .target(name: "Presentation"),
    ],
    configurations: Configuration.configurations,
    testConfigurations: Configuration.testConfigurations
)

let PresentationTargets: [Target] = Project.createAppTarget(
    name: "Presentation",
    destinations: .iOS,
    product: .framework,
    bundleId: "com.framework.presentation",
    deploymentTargets: Project.deployTarget,
    plistFolderName: name,
    plistFileName: "Info",
    entitlementFolderName: name,
    entitlementName: "Sample",
    sources: ["Sources/Presentation/**"],
    testSource: ["Tests/Presentation/**"],
    dependencies: [
        .target(name: "Domain"),
        Module.Assets.project
    ],
    configurations: Configuration.configurations,
    testConfigurations: Configuration.testConfigurations
)

let DataTargets: [Target] = Project.createAppTarget(
    name: "Data",
    destinations: .iOS,
    product: .framework,
    bundleId: "com.framework.data",
    deploymentTargets: Project.deployTarget,
    plistFolderName: name,
    plistFileName: "Info",
    entitlementFolderName: name,
    entitlementName: "Sample",
    sources: ["Sources/Data/**"],
    testSource: ["Tests/Data/**"],
    dependencies: [
        .target(name: "Domain"),
        Module.Utils.project
    ],
    configurations: Configuration.configurations,
    testConfigurations: Configuration.testConfigurations
)

let DomainTargets: [Target] = Project.createAppTarget(
    name: "Domain",
    destinations: .iOS,
    product: .framework,
    bundleId: "com.framework.domain",
    deploymentTargets: Project.deployTarget,
    plistFolderName: name,
    plistFileName: "Info",
    entitlementFolderName: name,
    entitlementName: "Sample",
    sources: ["Sources/Domain/**"],
    testSource: ["Tests/Domain/**"],
    configurations: Configuration.configurations,
    testConfigurations: Configuration.testConfigurations
)

let allTargets = [AppTargets, PresentationTargets, DataTargets, DomainTargets]
    .flatMap { $0 }

let projectConfigurations = Configuration.configurations + Configuration.testConfigurations

let schemes = Configuration.createAppSchemes(appName: name)

let rootProject = Project(
    name: name,
    options: .options(
        automaticSchemesOptions: .disabled, // 자동 스킴 생성 제어하여 스킴 배열을 명시적으로 관리
        defaultKnownRegions: defaultKnownRegions,
        developmentRegion: defaultKnownRegions.first!
    ),
    packages: [],
    settings: .settings(
        configurations: projectConfigurations,
        defaultConfiguration: "DEV_Debug"
    ),
    targets: allTargets,
    schemes: schemes,
    resourceSynthesizers: [
        .custom(name: "Assets", parser: .assets, extensions: ["xcassets"]),
        .custom(name: "Fonts", parser: .fonts, extensions: ["otf"]),
    ]
)


// 프로젝트 단위로 프레임워크 나눌 때

/*
let rootProject = Project.createProject(
    name: name,
    destinations: .iOS,
    product: .app,
    deploymentTargets: Project.deployTarget,
    plistFileName: "Info",
    entitlementName: "Sample",
    sources: ["Sources/**"],
    resources: [.glob(pattern:
            .relativeToRoot("SupportFiles/AppResources/**")
    )],
    testSource: ["Tests/**"],
    moduleNames: ["Presentations"],
    configurations: configurations,
    testConfigurations: testConfigurations,
    targetScripts: [ // 스크립트 입력 부분
        .pre(
            script: """
            echo "hello world"
            """,
            name: ""
        )
    ],
    dependencies: [
//        Module.Assets.project,
        /*
         .package(product: "Airbridge", type: .runtime),
         */
    ],
    package: [
        /*
         만약 SPM으로 불러올 패키지가 있는 경우 해당 파라미터에 추가
         .remote(
            url: "https://github.com/ab180/airbridge-ios-sdk-deployment",
            requirement: .upToNextMajor(from: "4.5.0")
         )
         */
    ],
    defaultKnownRegions:  ["ko", "en", "ja"], // list 내 frist 값이 default
    resourceSynthesizer: [
        .custom(name: "Assets", parser: .assets, extensions: ["xcassets"]),
        .custom(name: "Fonts", parser: .fonts, extensions: ["otf"]),
    ]
)
                        */*/*/*/
