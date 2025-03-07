//
//  ContentView.swift
//  swiftu-auth-clerk
//
//  Created by Anaru Herbert on 7/3/2025.
//

import LambdaspireAbstractions
import LambdaspireDependencyResolution
import LambdaspireSwiftUIFoundations
import SwiftUI

@ViewWithViewModel
struct RootView {
    var content: some View {
        VStack {
            if vm.authenticated {
                HomeScreen() 
            } else {
                AuthScreen()
            }
        }
    }
}

@ViewModel(generateEmpty: true)
final class RootViewViewModel {
    @Published private(set) var user: Loadable<User> = .notLoaded

    private var userContext: UserContext!

    var authenticated: Bool { user.isLoaded }
    var name: String {
        self.user.whenLoaded { User in
            return User.name
        } else: {
            ""
        }
    }

    init(userContext: UserContext!) {
        self.userContext = userContext
    }

    func postInitialise() {
        userContext
            .$user
            .receive(on: DispatchQueue.main)
            .assign(to: &$user)
    }
}

#Preview {
    RootView()
        .previewContainer { b in
            b.singleton(UserContext.self)
            b.singleton(IAuthService.self, assigned(MockAuthService.self))
        }
}

@ResolvedScope
struct WelcomeUserNavTitle : ViewModifier {
    
        // @EnvironmentObject might be a more appropriate way to do this
        // as it will follow the SwiftUI view update cycle better.
        // However, purely as an example of how to resolve dependencies inline
        // in a View, here's resolving UserContext and passing it to some
        // other View's / Modifier's @ObservedObject parameter.
    @Resolved private var userContext: UserContext
    
    func body(content: Content) -> some View {
        content.modifier(_WelcomeUserNavTitle(userContext: userContext))
    }
}

struct _WelcomeUserNavTitle : ViewModifier {
    
    @ObservedObject var userContext: UserContext
    
    func body(content: Content) -> some View {
        content.navigationTitle(
            userContext.user.whenLoaded {
                "Welcome, \($0.name)"
            } else: {
                "Welcome"
            })
    }
}

extension View {
    func welcomeUserNavTitle() -> some View {
        modifier(WelcomeUserNavTitle())
    }
}