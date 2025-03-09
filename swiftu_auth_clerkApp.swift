import Clerk
import Factory
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
    func getCurrentUser() async -> User?;
}

@MainActor
public class ClerkAuthService: AuthService {
    
    
    private var clerk: Clerk = Clerk.shared
    
    func getCurrentUser()  -> User? {
        if clerk.session != nil {
            let user = clerk.user
            return .init(name: user?.firstName ?? "User")
        }
        
        return nil
    }
    

    func signIn() async throws -> User {

        let signInStrategy = try await SignIn.create(
            strategy: .oauth(provider: .google))

        print(signInStrategy)

        try await signInStrategy.authenticateWithRedirect(
            prefersEphemeralWebBrowserSession: false)
        let authenticatedUser = clerk.user!

        let result = User(name: authenticatedUser.firstName ?? "N/A")

        return result

    }

    func signOut() async throws {
        try await clerk.signOut()
    }

}

@MainActor
public class MockAuthService: AuthService {
    private var testUser : User? = nil
    
    func getCurrentUser() async -> User? {
        return testUser
    }
    
    func signIn() async throws -> User {
        testUser = .init(name: "Test User")
        return testUser!
    }

    func signOut() async throws {
        testUser = nil
    }
}

struct User {
    var name: String
}
