import Clerk
import LambdaspireAbstractions
import LambdaspireDependencyResolution
import LambdaspireSwiftUIFoundations
import SwiftUI

@ViewWithViewModel
struct RootView {
    var content: some View {
        ZStack {
            if vm.loaded {
                if vm.authenticated {
                    TabView {
                        //                        Dashboard()
                        //                            .tabItem {
                        //                            Label(
                        //                                "Dashboard",
                        //                                systemImage:
                        //                                    "bolt.fill")
                        Text("Hello")
                    }
                }
            } else {
                Button("Sign In") {
                    vm.signIn()
                }

            }

        }.onAppear { self.vm.getCurrentUser() }
    }

}

@ViewModel(generateEmpty: true)
final class RootViewViewModel {
    @Published private(set) var user: Loadable<User> = .notLoaded
    @Published private(set) var loaded: Bool = false
    private var userContext: UserContext!

    var authenticated: Bool { user.isLoaded }

    init(userContext: UserContext) {
        self.userContext = userContext
    }

    func signIn() {
        userContext.signIn()
    }

    func getCurrentUser() {
        userContext.getCurrentUser()
    }
    
    func postInitalise() {
        userContext
            .$loadedUser
            .receive(on: DispatchQueue.main)
            .assign(to: &$user)
        
        userContext
            .$loaded
            .receive(on: DispatchQueue.main)
            .assign(to: &$loaded)
    }

}

#Preview {
    RootView()
        .previewContainer { b in
            b.singleton(UserContext.self)
            b.singleton(AuthService.self, assigned(MockAuthService.self))
        }
}