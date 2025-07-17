//
//  Module.swift
//  TuistExtension
//
//  Created by 이재훈 on 7/16/25.
//

import ProjectDescription

public enum Module: String, CaseIterable {
    case Assets
    case Utils
    
    public var path: ProjectDescription.Path {
        .relativeToRoot("Projects/" + self.rawValue)
    }
    
    public var project: TargetDependency {
        .project(target: self.rawValue, path: self.path)
    }
}
