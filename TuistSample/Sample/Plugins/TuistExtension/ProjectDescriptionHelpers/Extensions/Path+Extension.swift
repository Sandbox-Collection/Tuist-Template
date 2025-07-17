//
//  Path+Extension.swift
//  TuistExtension
//
//  Created by 이재훈 on 7/16/25.
//

import ProjectDescription

extension Path {
    public static func plistPath(
        folderName: String = "",
        fileName: String
    ) -> Path {
        let path = folderName.isEmpty ? "" : "\(folderName)/"
        return .relativeToRoot("SupportFiles/InfoPlist/\(path)\(fileName).plist")
    }
    
    public static func xcconfigPath(
        folderName: String = "",
        fileName: String
    ) -> Path {
        let path = folderName.isEmpty ? "" : "\(folderName)/"
        return .relativeToRoot("SupportFiles/XCConfigs/\(path)\(fileName).xcconfig")
    }
    
    public static func entitlementsPath(
        folderName: String = "",
        fileName: String
    ) -> Path {
        let path = folderName.isEmpty ? "" : "\(folderName)/"
        return .relativeToRoot("SupportFiles/Entitlements/\(path)\(fileName).entitlements")
    }
    
    public static func scriptPath(_ scriptName: String) -> Path {
      return .relativeToRoot("SupportFiles/Tools/\(scriptName)")
    }
}
