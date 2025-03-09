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
