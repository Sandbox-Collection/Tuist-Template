//
//  Project.swift
//  Config
//
//  Created by 이재훈 on 7/16/25.
//

import TuistExtension
import ProjectDescription

let utilsProject = Project.createProject(
    name: "Utils",
    destinations: .iOS,
    product: .framework,
    testBundleId: Project.teamId + "utils",
    deploymentTargets: Project.deployTarget,
    sources: ["Sources/**"],
    testSource: ["Tests/**"],
    configurations: Configuration.configurations,
    testConfigurations: Configuration.testConfigurations
)
