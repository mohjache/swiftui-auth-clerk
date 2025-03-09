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
