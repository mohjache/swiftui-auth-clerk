protocol IAuthService {
    func signIn() async throws -> User
    func signOut() async throws
}

struct User {
    var name: String
}

