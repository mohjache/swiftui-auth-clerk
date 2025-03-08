//
//  ClerkAuthService.swift
//  swiftu-auth-clerk
//
//  Created by Anaru Herbert on 8/3/2025.
//

import Clerk
import SwiftUI


public class ClerkAuthService : AuthService{
    @Environment(Clerk.self) private var clerk
    func signIn() async throws -> User {
        try await Task.sleep(nanoseconds: 1000000000)
        return .init(name: "User \(Int.random(in: 100...999))")
    }
    
    func signOut() async throws {
        try await Task.sleep(nanoseconds: 1000000000)
    }
}
