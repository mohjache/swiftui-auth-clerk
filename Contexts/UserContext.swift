import SwiftUI
import LambdaspireAbstractions
import LambdaspireDependencyResolution

@Resolvable
class UserContext: ObservableObject {
    
    @Published var loadedUser: Loadable<User> = .notLoaded
    @Published var loaded : Bool = false
    
    private let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func getCurrentUser() {
        Task {

            let currentUser = await authService.getCurrentUser()
            
            if currentUser != nil {
                loadedUser = .loaded(currentUser!)
            }
            
            loaded = true
        }
    }

    func signIn() {
        loadedUser = .loading
        Task {
            do {
                loadedUser = .loaded(try await authService.signIn())
            } catch {
                print(error)
                loadedUser = .error(error)
            }
        }
    }

    func signOut() {
        loadedUser = .loading
        Task {
            do {
                try await authService.signOut()
                loadedUser = .notLoaded
            } catch {
                loadedUser = .error(error)
            }
        }
    }
}

