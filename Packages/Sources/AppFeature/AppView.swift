import AuthFeature
import SwiftUI

public struct AppView: View {

    @State private var isShowingAuth: Bool = false
    @State private var isSignedIn: Bool = false

    public init() {}

    public var body: some View {
        VStack {
            Text(isSignedIn ? "I’m signed in!" : "I’m not signed in yet!")
            Button("Show Auth") {
                isShowingAuth = true
            }
        }
        .sheet(isPresented: $isShowingAuth) {
            AuthView(didSignIn: {
                isSignedIn = true
                isShowingAuth = false
            })
        }
    }
}

#Preview {
    AppView()
}
