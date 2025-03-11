import Factory
import SwiftUI

struct Dashboard: View {
    @StateObject private var vm = ViewModel()
    @Injected(\.userContext) private var userContext

    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(vm.useableData, id: \.self) {d in
                        Text(d)
                    }
                }
            }
            .navigationTitle(
                userContext.loadedUser.whenLoaded {
                    "Welcome, \($0.name)"
                } else: {
                    "Welcome"
                }
            )
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        vm.signOut()
                    } label: {
                        Text("Sign Out")
                    }
                }
            }
        }.onAppear{
            vm.getData()
        }

    }
}

extension Dashboard {
    class ViewModel: ObservableObject {
        @Published private(set) var data: Loadable<[String]> = .notLoaded
        @Injected(\.userContext) private var userContext
        @Injected(\.dataContext) private var dataContext
        
        var useableData : [String] {
            data.whenLoaded {
                return $0
            } else: {
                return []
            }        
        }
        
        init() {
            dataContext
                .$history
                .receive(on: DispatchQueue.main)
                .assign(to: &$data)
        }

        func getData() {
            dataContext.getData()
        }

        func signOut() {
            userContext.signOut()
        }
    }
}

struct RootView_Preview: PreviewProvider {
    static var previews: some View {

        let _ = Container.shared.auth.register { @MainActor in MockAuthService()
        }.singleton
        let _ = Container.shared.userContext.register { UserContext() }
            .singleton
        let _ = Container.shared.dataContext.register { DataContext() }
        let _ = Container.shared.api.register { MockApiService() }
        let _ = Container.shared.userContext().signIn()

        Dashboard()
    }
}
