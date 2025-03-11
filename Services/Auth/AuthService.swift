protocol AuthService {
    func signIn() async throws -> User
    func signOut() async throws
    func getCurrentUser() async -> User?;
}
