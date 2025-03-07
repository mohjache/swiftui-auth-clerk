
import Foundation
import LambdaspireDependencyResolution
import LambdaspireAbstractions

@Resolvable
class ClerkAuthService : IAuthService {
    func signIn() async throws -> User {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        return .init(name: "User \(Int.random(in: 100...999))")
    }
    
    func signOut() async throws {
        try await Task.sleep(nanoseconds: 1_000_000_000)
    }
}


