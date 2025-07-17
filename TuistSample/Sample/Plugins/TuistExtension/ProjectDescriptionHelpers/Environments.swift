//
//  Environments.swift
//  TuistExtension
//
//  Created by 이재훈 on 7/16/25.
//

import ProjectDescription

public extension Project {
    static let appName: String = "Sample"
    
    static let deployTarget: DeploymentTargets = .iOS("18.0")
    
    static let appPath: ProjectDescription.Path = .relativeToRoot("Projects/App")
    
    static let teamId: String = "com.importants"
}


