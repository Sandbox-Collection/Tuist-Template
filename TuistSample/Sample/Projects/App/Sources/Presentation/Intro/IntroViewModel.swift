//
//  IntroViewModel.swift
//  Data
//
//  Created by 이재훈 on 7/18/25.
//

import Foundation
import Domain

final class IntroViewModel: ObservableObject {
    private let checkVersionUseCase: CheckVersionUseCaseInterface
    @Published var isLatest: Bool?
    public init(checkVersionUseCase: CheckVersionUseCaseInterface) {
        self.checkVersionUseCase = checkVersionUseCase
    }
    func checkVersion() {
        Task {
            do {
                let result = try await checkVersionUseCase.execute()
                await MainActor.run {
                    self.isLatest = result
                }
            } catch {
                print("버전 확인 실패: \(error)")
                self.isLatest = nil
            }
        }
    }
}
