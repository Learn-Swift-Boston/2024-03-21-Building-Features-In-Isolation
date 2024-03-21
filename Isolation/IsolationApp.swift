import AppFeature
import AuthFeature
import SwiftUI

@main
struct IsolationApp: App {
    init() {
        // sketch of persistence
//        Database.shared.registerTables(
//            AuthFeature.dbTables,
//            HomeFeature.dbTables,
//        )
    }

    var body: some Scene {
        WindowGroup {
            AppView()
                .onAppear {
                    AuthClient.shared.signIn = { email, pass in

                        // reach out to network and do stuff
                        return true
                    }
                }

        }
    }
}
