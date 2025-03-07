//
//  swiftu_auth_clerkApp.swift
//  swiftu-auth-clerk
//
//  Created by Anaru Herbert on 7/3/2025.
//


import LambdaspireAbstractions
import LambdaspireDependencyResolution
import LambdaspireSwiftUIFoundations
import SwiftUI

@main
struct swiftu_auth_clerkApp: App {
    private let rootScope: DependencyResolutionScope = getAppContainer()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .resolving(from: rootScope)
        
        }
    }
}
