//
//  VersionRepositoryMock.swift
//  Data
//
//  Created by 이재훈 on 7/18/25.
//

import Foundation
import Domain

public final class VersionRepository: VersionRepositoryInterface {
    public func fetchRemoteVersion() async throws -> String {
        // remote config 등에서 버전 가져오기
    }

    public func getCurrentAppVersion() -> String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
}


public final class VersionRepositoryMock: VersionRepositoryInterface {
    public func fetchRemoteVersion() async throws -> String { "1.0.0" }
    public func getCurrentAppVersion() -> String { "1.0.0" }
}
