import Clerk
import SwiftUI

@main
struct swiftu_auth_clerkApp: App {
    private var clerk = Clerk.shared

    var body: some Scene {
        WindowGroup {
            ZStack {
                if clerk.isLoaded {
                    RootView()
                } else {
                    Text("Loading")
                }

            }
            .task {
                clerk.configure(
                    publishableKey:
                        ApplicationConfig.clerkApiKey)
                try? await clerk.load()

            }

        }
    }

}
