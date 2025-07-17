import Foundation
import Testing
import SwiftUI

@testable import Sample

final class SampleTest {
    init() {}
    @Test("sample Test")
    func TestingFunction() {
        let contentView = ContentView()
        let flag = contentView.printEnvironment()
        print("flag: \(flag)")
        // given
        
        // when
        
        // then
        #expect(flag == "DEV")
    }
}
