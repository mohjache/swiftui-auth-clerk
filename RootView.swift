import Clerk
import Factory
import SwiftUI

struct RootView: View {
    @StateObject private var vm = ViewModel()
    var body: some View {
        ZStack {
            if vm.loaded {
                if vm.authenticated {
                    TabView {
                        Dashboard()
                            .tabItem {
                            Label(
                                "Dashboard",
                                systemImage:
                                    "bolt.fill")
                        }
                    }
                } else {
                    Button("Sign In") {
                        vm.signIn()
                    }
                    
                }
            }
        }.onAppear { self.vm.getCurrentUser() }
    }

}

extension RootView {
    class ViewModel: ObservableObject {
        @Published private(set) var user: Loadable<User> = .notLoaded
        @Published private(set) var loaded: Bool = false
        @Injected(\.userContext) private var userContext

        var authenticated: Bool { user.isLoaded }

        init() {
            userContext
                .$loadedUser
                .receive(on: DispatchQueue.main)
                .assign(to: &$user)
            
            userContext
                .$loaded
                .receive(on: DispatchQueue.main)
                .assign(to: &$loaded)
        }

        func signIn() {
            userContext.signIn()
        }


        func getCurrentUser() {
            userContext.getCurrentUser()
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        let _ = Container.shared.auth.register { @MainActor in MockAuthService()
        }
        let _ = Container.shared.userContext.register { UserContext() }
        RootView()
    }
}
