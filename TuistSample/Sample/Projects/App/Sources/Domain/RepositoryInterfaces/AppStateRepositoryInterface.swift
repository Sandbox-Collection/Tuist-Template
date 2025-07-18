//
//  AppStateRepository.swift
//  Data
//
//  Created by 이재훈 on 7/18/25.
//

import Foundation

public protocol VersionRepositoryInterface {
    func fetchRemoteVersion() async throws -> String
    func getCurrentAppVersion() -> String
}
