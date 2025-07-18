//
//  Configuration+Extension.swift
//  TuistExtension
//
//  Created by 이재훈 on 7/16/25.
//

import ProjectDescription

public extension Configuration {
    enum ConfigScheme: String, CaseIterable {
        case DEV
        case STAGING
        case PROD
        
        var debugName: ConfigurationName {
            ConfigurationName(stringLiteral: self.rawValue + "_Debug")
        }
        
        var releaseName: ConfigurationName {
            ConfigurationName(stringLiteral: self.rawValue + "_Release")
        }
        
        func scheme(appName: String) -> Scheme {
            let targetName = "\(appName)-\(self.rawValue)"
            let testTargetName = "\(appName)_test"
            let testConfigName = "Test" + self.debugName.rawValue
            
            return .scheme(
                name: targetName,
                shared: true,
                buildAction: .buildAction(targets: [.target(appName)]),
                testAction: .targets(["\(testTargetName)"], configuration: ConfigurationName(stringLiteral: testConfigName)),
                runAction: .runAction(configuration: self.debugName),
                archiveAction: .archiveAction(configuration: self.releaseName),
                profileAction: .profileAction(configuration: self.releaseName),
                analyzeAction: .analyzeAction(configuration: self.debugName)
            )
        }
    }
    
    static let configurations: [Configuration] = {
        let name = Project.appName
        let configurations: [Configuration] = Configuration.ConfigScheme.allCases.flatMap { configScheme in
            return Configuration.createAppConfiguration(appName: name, configScheme: configScheme)
        }
        return configurations
    }()
    
    static let testConfigurations: [Configuration] = {
        let testConfigurations: [Configuration] = Configuration.ConfigScheme.allCases.flatMap { configScheme in
            return Configuration.createTestConfiguration(configScheme: configScheme)
        }
        return testConfigurations
    }()
    
    static func createAppConfiguration(
        appName: String = "",
        configScheme: ConfigScheme
    ) -> [Configuration] {
        return [
            .release(
                name: configScheme.releaseName,
                xcconfig: .xcconfigPath(
                    folderName: appName,
                    fileName: configScheme.releaseName.rawValue
                )
            ),
            .debug(
                name: configScheme.debugName,
                xcconfig: .xcconfigPath(
                    folderName: appName,
                    fileName: configScheme.debugName.rawValue
                )
            )
        ]
    }
    
    static func createTestConfiguration(
        configScheme: ConfigScheme
    ) -> [Configuration] {
        let schemeName: String = configScheme.rawValue
        let xcconfigPath: Path = .xcconfigPath(
            folderName: "Test",
            fileName: "Test_\(schemeName)"
        )
        let debugName = "Test" + configScheme.debugName.rawValue
        return [
            .debug(
                name: ConfigurationName(stringLiteral: debugName),
                xcconfig: xcconfigPath
            )
        ]
    }
    
    static func createModuleConfiguration(
        configScheme: ConfigScheme
    ) -> [Configuration] {
        return [
            .release(
                name: configScheme.releaseName,
                xcconfig: .xcconfigPath(
                    fileName: "Module")
            ),
            .debug(
                name: configScheme.debugName,
                xcconfig: .xcconfigPath(
                    fileName: "Module")
            )
        ]
    }
    
    static func createAppSchemes(appName: String) -> [Scheme] {
        return ConfigScheme.allCases.map { $0.scheme(appName: appName) }
    }
    
    static func createModuleSchemes(frameworkName: String) -> [Scheme] {
        return [
            .scheme(
                name: frameworkName,
                shared: true,
                buildAction: .buildAction(targets: [.target(frameworkName)]),
                testAction: .targets(["\(frameworkName)_test"], configuration: "DEV_Debug"),
                runAction: .runAction(configuration: "DEV_Debug")
                )
        ]
    }
}
