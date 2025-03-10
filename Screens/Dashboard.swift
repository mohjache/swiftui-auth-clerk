import SwiftUI
import Factory

struct Dashboard : View {
    @StateObject private var vm = ViewModel()
    @Injected(\.userContext) private var userContext
    
    private var data = ["Hello", "World"]
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(data, id: \.self) {d in
                        Text(d)
                    }
                }
            }
            .navigationTitle(
                userContext.loadedUser.whenLoaded {
                    "Welcome, \($0.name)"
                } else: {
                    "Welcome"
                })
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        vm.signOut()
                    } label: {
                        Text("Sign Out")
                    }
                }
            }
        }
        
    }
}

extension Dashboard {
    class ViewModel : ObservableObject {
        @Published private(set) var user: Loadable<User> = .notLoaded
        @Injected(\.userContext) private var userContext   
    
        func signOut() {
            userContext.signOut()
        }
    }
}

struct RootView_Preview : PreviewProvider {
    static var previews: some View {
       
        let _ = Container.shared.auth.register {@MainActor in MockAuthService()}.singleton
        let _  = Container.shared.userContext.register {UserContext()}.singleton
        let _ = Container.shared.userContext().signIn()

        Dashboard()
    }
}
