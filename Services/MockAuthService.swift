//
//  MockAuthService.swift
//  swiftu-auth-clerk
//
//  Created by Anaru Herbert on 8/3/2025.
//


class MockAuthService : AuthService {
    
    func signIn() async throws -> User { .init(name: "Mock User") }
    
    func signOut() async throws {
            // Okay.
    }
}
