//
//  CheckVersionUseCase.swift
//  Data
//
//  Created by 이재훈 on 7/18/25.
//

import Foundation

public protocol CheckVersionUseCaseInterface {
    func execute(
    ) async throws -> Bool
}

final public class CheckVersionUseCase: CheckVersionUseCaseInterface {
    private let versionRepository: VersionRepositoryInterface
    public init(
        versionRepository: VersionRepositoryInterface
    ) {
        self.versionRepository = versionRepository
    }
    public func execute() async throws -> Bool {
        let remoteVersion = try await versionRepository.fetchRemoteVersion()
        let currentVersion = versionRepository.getCurrentAppVersion()
        return remoteVersion == currentVersion
    }
}
