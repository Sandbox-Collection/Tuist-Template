//
//  Project+Extension.swift
//  TuistExtension
//
//  Created by 이재훈 on 7/16/25.
//

import Foundation
import ProjectDescription

extension Project {
    public static func createProject(
        name: String,
        destinations: Destinations,
        product: Product,
        bundleId: String = "$(APP_IDENTIFIER)",
        testBundleId: String = "$(APP_IDENTIFIER)",
        schemes: [Scheme] = [],
        deploymentTargets: DeploymentTargets?,
        plistFileName: String = "Info",
        entitlementName: String? = nil,
        sources: SourceFilesList?,
        resources: ResourceFileElements? = nil,
        testSource: SourceFilesList?,
        moduleNames: [String] = [],
        configurations: [Configuration] = [],
        testConfigurations: [Configuration] = [],
        targetScripts: [TargetScript] = [],
        dependencies: [TargetDependency] = [],
        package: [Package] = [],
        targets: [Target] = [],
        defaultKnownRegions: [String]? = nil,
        resourceSynthesizer: [ResourceSynthesizer]? = nil
    ) -> Project {
        var mainTargets: [Target] = []
        var schemes = schemes
        switch product {
        case .app:
            mainTargets = createAppTarget(
                name: name,
                destinations: destinations,
                product: product,
                bundleId: bundleId,
                testBundleId: testBundleId,
                deploymentTargets: deploymentTargets,
                plistFolderName: name,
                plistFileName: plistFileName,
                entitlementFolderName: name,
                entitlementName: entitlementName,
                sources: sources,
                resources: resources,
                testSource: testSource,
                targetScripts: targetScripts,
                configurations: configurations,
                testConfigurations: testConfigurations
            )
            schemes.append(contentsOf: Configuration.createAppSchemes(appName: name))
            return .init(
                name: name,
                options: product == .app
                ? .options(
                    automaticSchemesOptions: .disabled,
                    defaultKnownRegions: defaultKnownRegions, // 다국어 적용
                    developmentRegion: defaultKnownRegions?.first // default 값
                )
                : .options(),
                packages: package,
                settings: .settings(
                    configurations: configurations + testConfigurations,
                    defaultConfiguration: "DEV_Debug"
                ),
                targets: mainTargets + targets,
                schemes: schemes,
                resourceSynthesizers: resourceSynthesizer ?? .default
            )
        case .framework, .staticFramework:
            mainTargets = createModuleTargets(
                name: name,
                destinations: destinations,
                product: product,
                bundleId: bundleId,
                testBundleId: testBundleId,
                deploymentTargets: deploymentTargets,
                sources: sources,
                resources: resources,
                testSource: testSource,
                targetScripts: targetScripts,
                dependencies: dependencies,
                configurations: configurations,
                testConfigurations: testConfigurations
            )
            schemes.append(contentsOf: Configuration.createModuleSchemes(frameworkName: name))
            return .init(
                name: name,
                options: product == .app
                ? .options(
                    automaticSchemesOptions: .disabled,
                    defaultKnownRegions: defaultKnownRegions,
                    developmentRegion: defaultKnownRegions?.first
                )
                : .options(
                    automaticSchemesOptions: .disabled
                ),
                packages: package,
                settings: .settings(
                    configurations: configurations + testConfigurations,
                    defaultConfiguration: "DEV_Debug"
                ),
                targets: mainTargets + targets,
                schemes: schemes,
                resourceSynthesizers: resourceSynthesizer ?? .default
            )
        default:
            fatalError()
        }
    }
    
    public static func createAppTarget(
        name: String,
        destinations: Destinations,
        product: Product,
        bundleId: String = "$(APP_IDENTIFIER)",
        testBundleId: String = "$(APP_IDENTIFIER)",
        deploymentTargets: DeploymentTargets?,
        plistFolderName: String = "",
        plistFileName: String = "Info",
        entitlementFolderName: String = "",
        entitlementName: String? = nil,
        sources: SourceFilesList? = nil,
        resources: ResourceFileElements? = nil,
        testSource: SourceFilesList?,
        targetScripts: [TargetScript] = [],
        dependencies: [TargetDependency] = [],
        configurations: [Configuration],
        testConfigurations: [Configuration]
    ) -> [Target] {
        return [
            Target.target(
                name: name,
                destinations: destinations,
                product: product,
                bundleId: bundleId,
                deploymentTargets: deploymentTargets,
                infoPlist: .file(
                    path: .plistPath(
                        folderName: plistFolderName,
                        fileName: plistFileName
                    )
                ),
                sources: sources,
                resources: resources,
                entitlements: .file(
                    path: .entitlementsPath(
                        folderName: entitlementFolderName,
                        fileName: entitlementName ?? name
                    )
                ),
                scripts: targetScripts,
                dependencies: dependencies,
                settings: .settings(
                    configurations: configurations
                    // defaultConfiguration: "DEV_Debug" > Project에 defaultConfiguration가 설정되어 있기 때문에 Project Default를 우선 사용
                )
            ),
            .target(
                name: "\(name)_test",
                destinations: destinations,
                product: .unitTests,
                bundleId: testBundleId,
                deploymentTargets: deploymentTargets,
                sources: testSource,
                dependencies: [.target(name: name)],
                settings: .settings(
                    configurations: testConfigurations
                )
            )
        ]
    }
    
    private static func createModuleTargets(
        name: String,
        destinations: Destinations,
        product: Product,
        bundleId: String = "$(APP_IDENTIFIER)",
        testBundleId: String,
        deploymentTargets: DeploymentTargets?,
        sources: SourceFilesList?,
        resources: ResourceFileElements?,
        testSource: SourceFilesList?,
        targetScripts: [TargetScript],
        dependencies: [TargetDependency] = [],
        configurations: [Configuration],
        testConfigurations: [Configuration]
    ) -> [Target] {
        return [
            .target(
                name: name,
                destinations: destinations,
                product: product,
                bundleId: bundleId,
                deploymentTargets: deploymentTargets,
                sources: sources,
                resources: resources,
                scripts: targetScripts,
                dependencies: dependencies,
                settings: .settings(configurations: configurations)
            ),
            .target(
                name: "\(name)_test",
                destinations: destinations,
                product: .unitTests,
                bundleId: testBundleId,
                deploymentTargets: deploymentTargets,
                sources: testSource,
                dependencies: [.target(name: name)],
                settings: .settings(
                    configurations: testConfigurations
                )
            )
        ]
    }
}
