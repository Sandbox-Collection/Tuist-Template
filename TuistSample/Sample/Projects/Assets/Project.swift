//
//  Project.swift
//  Config
//
//  Created by 이재훈 on 7/16/25.
//

import TuistExtension
import ProjectDescription

let assetsProject = Project.createProject(
    name: "Assets",
    destinations: .iOS,
    product: .framework,
    testBundleId: Project.teamId + "assets",
    deploymentTargets: Project.deployTarget,
    sources: ["Sources/**"],
    resources: .default,
    testSource: ["Tests/**"],
    configurations: Configuration.configurations,
    testConfigurations: Configuration.testConfigurations,
    dependencies: [
        Module.Utils.project
    ]
)
