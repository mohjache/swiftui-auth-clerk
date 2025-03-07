
import Combine
import LambdaspireAbstractions
import LambdaspireDependencyResolution
import LambdaspireSwiftUIFoundations

@Resolvable
class UserContext : ObservableObject {
    @Published private(set) var user: Loadable<User> = .notLoaded
    
    private let auth: IAuthService
    
    init(auth: IAuthService) {
        self.auth = auth
    }
    
    func signIn() {
        user = .loading
        Task {
            do {
                user = .loaded(try await auth.signIn())
            } catch {
                user = .error(error)
            }
        }
    }
    
    func signOut() {
        user = .loading
        Task {
            do {
                try await auth.signOut()
                user = .notLoaded
            } catch {
                user = .error(error)
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
        whenLoaded { _ in true } else: { false }
    }
    
    func whenLoaded<R>(_ fn: (T) -> R, else efn: () -> R) -> R {
        if case let .loaded(t) = self {
            return fn(t)
        }
        return efn()
    }
}
