//
//  swiftu_auth_clerkApp.swift
//  swiftu-auth-clerk
//
//  Created by Anaru Herbert on 7/3/2025.
//

import Clerk
import SwiftUI
import Factory
@main
struct swiftu_auth_clerkApp: App {
    private var clerk = Clerk.shared
    var body: some Scene {
        WindowGroup {
            ZStack {
                if clerk.isLoaded {
                    RootView()
                } else {
                    LoadingView()
                }
            }
                .environment(clerk)
                .task {
                    clerk.configure(publishableKey: "pk_test_a25vd24tbWFuLTIwLmNsZXJrLmFjY291bnRzLmRldiQ")
                    try? await clerk.load()
                }
        }        
    }
    
}

extension Container {
    var authService: Factory<AuthService> {
        self { ClerkAuthService() }.singleton
    }
    
    var userContext : Factory<UserContext> {
        self{UserContext()}.singleton
    }
    
}

struct User  {
    var name: String
}






