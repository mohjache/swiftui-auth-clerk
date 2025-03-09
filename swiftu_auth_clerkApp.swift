import Clerk
import Factory
import SwiftUI

@main
struct swiftu_auth_clerkApp: App {
    private var clerk = Clerk.shared

    var body: some Scene {
        WindowGroup {
            ZStack {
                RootView()
            }
            //.environment(clerk)
            .task {
                clerk.configure(
                    publishableKey:
                        "pk_test_a25vd24tbWFuLTIwLmNsZXJrLmFjY291bnRzLmRldiQ")
                try? await clerk.load()

            }

        }
    }

}

extension Container {
    var auth: Factory<AuthService> {
        self { @MainActor in ClerkAuthService() }.singleton
    }
    var userContext: Factory<UserContext> {
        self { UserContext() }.singleton
    }
}

protocol AuthService {
    func signIn() async throws -> User
    func signOut() async throws
}

@MainActor
public class ClerkAuthService: AuthService {
    private var clerk: Clerk = Clerk.shared

    func signIn() async throws -> User {

        let signInStrategy = try await SignIn.create(
            strategy: .oauth(provider: .google))

        try await signInStrategy.authenticateWithRedirect(
            prefersEphemeralWebBrowserSession: false)
        let authenticatedUser = clerk.user!

        let result = User(name: authenticatedUser.firstName ?? "N/A")

        return result
    }

    func signOut() async throws {
        // yep
    }

}

@MainActor
public class MockAuthService: AuthService {
    func signIn() async throws -> User {
        return .init(name: "Test User")
    }

    func signOut() async throws {
        //yolo
    }
}

struct User {
    var name: String
}
