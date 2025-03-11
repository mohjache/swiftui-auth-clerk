import Foundation
import Combine
import Factory

class DataContext : ObservableObject {
    @Published private(set) var history : Loadable<[String]> = .notLoaded
    @Injected(\.api) private var apiService
    
    func getData() {
        history = .loading
        Task {
            let newData = try await apiService.getData()
            history = .loaded(newData)
        }
    }
}
