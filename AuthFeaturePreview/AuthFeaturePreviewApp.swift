import AuthFeature
import SwiftUI

@main
struct AuthFeaturePreviewApp: App {

    @State var rightCredentials: Bool = false

    init() {
        // Sketch of persistence
//        Database.shared.registerTables(
//            AuthFeature.dbTables,
//        )
    }

    var body: some Scene {
        WindowGroup {
            AuthView(
                didSignIn: {
                    print("did sign in")
                }
            )
            .overlay(alignment: .bottomTrailing) {
                Form {
                    Section("Dev Settings") {
                        Toggle("Right Credentials", isOn: $rightCredentials)
                    }
                }
                .frame(width: 200, height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 30)
                .padding()
            }
            .onAppear {
                AuthClient.shared.signIn = { email, pass in

                    // reach out to network and do stuff
                    return rightCredentials
                }
            }
        }
    }
}
