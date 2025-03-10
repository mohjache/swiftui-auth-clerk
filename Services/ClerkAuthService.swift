import Clerk
import LambdaspireDependencyResolution
import LambdaspireAbstractions

@MainActor
@Resolvable
class ClerkAuthService: AuthService {
    
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
