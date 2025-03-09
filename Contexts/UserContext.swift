import Factory
import SwiftUI


class UserContext : ObservableObject {
    @Injected(\.auth) private var authService
    @Published var loadedUser: Loadable<User> = .notLoaded
    
    func signIn() {
        loadedUser = .loading
        Task {
            do {
                loadedUser = .loaded(try await authService.signIn())
            } catch {
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

enum Loadable<T> {
    case notLoaded
    case loading
    case loaded(T)
    case error(Error)
}

extension Loadable {

    var isLoaded: Bool {
        whenLoaded { _ in
            true
        } else: {
            false
        }
    }

    func whenLoaded<R>(_ fn: (T) -> R, else efn: () -> R) -> R {
        if case let .loaded(t) = self {
            return fn(t)
        }
        return efn()
    }
}
