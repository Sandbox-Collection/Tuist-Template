import SwiftUI

public struct ContentView: View {
    @State private var state: String = "Hello, World!"
    public init() {}
    
    public var body: some View {
        Button {
            state = printEnvironment()
        } label: {
            Text(state)
                .padding()
        }
    }
    
    public func printEnvironment() -> String {
        let value: String
#if DEV
        value = "DEV"
        print("DEV")
#elseif STAGING
        value = "STAGING"
        print("STAGING")
#else
        value = "PROD"
        print("PROD")
#endif
        return value
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

public class Hello {
    func hello() -> String {
        return "Hello, World!"
    }
}
