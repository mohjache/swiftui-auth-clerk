
import LambdaspireAbstractions
import LambdaspireDependencyResolution

@Resolvable
class MockAuthService : IAuthService {
    
    func signIn() async throws -> User { .init(name: "Mock User") }
    
    func signOut() async throws {
            // Okay.
    }
}