import Factory
import SwiftUI

struct RootView: View {
    @StateObject private var vm = RootViewViewModel()
    var body: some View {
        VStack {
            if !vm.autenticated {
                Button {
                    vm.signIn()

                } label: {
                    Text("Sign In")
                }
            } else {
                Text("hello")
            }
        }
    }
}

class RootViewViewModel: ObservableObject {
    @Published private(set) var user: Loadable<User> = .notLoaded
    @Injected(\.userContext) private var userContext

    var autenticated: Bool { user.isLoaded }

    init() {
        userContext
            .$user
            .receive(on: DispatchQueue.main)
            .assign(to: &$user)
    }

    func signIn() {
        userContext.signIn()
    }

}

struct LoadingView: View {
    var body: some View {
        Text("Hello")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let _ = Container.shared.authService.register { MockAuthService() }
            .singleton
        let _ = Container.shared.userContext.register { UserContext() }
            .singleton
        RootView()
    }
}
