//
//  IntroView.swift
//  Data
//
//  Created by 이재훈 on 7/18/25.
//

import SwiftUI

struct IntroView: View {
    @StateObject var viewModel: IntroViewModel

    var body: some View {
        VStack {
            if let isLatest = viewModel.isLatest {
                Text(isLatest ? "최신 버전입니다." : "업데이트가 필요합니다.")
            } else {
                Text("버전 확인 중...")
            }
        }
        .onAppear {
            viewModel.checkVersion()
        }
    }
}
