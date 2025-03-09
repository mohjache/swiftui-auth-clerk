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
                        "pk_test_a25vd24tbWFuLTIwLmNsZXJrLmFjY291bnRzLmRldiQ")
                try? await clerk.load()

            }

        }
    }

}
