//
//  AuthService.swift
//  swiftu-auth-clerk
//
//  Created by Anaru Herbert on 8/3/2025.
//


protocol AuthService {
    func signIn() async throws -> User
    func signOut() async throws
}