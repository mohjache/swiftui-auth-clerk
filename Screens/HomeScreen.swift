
import SwiftUI
import LambdaspireAbstractions
import LambdaspireDependencyResolution
import LambdaspireSwiftUIFoundations


@ViewWithViewModel
struct HomeScreen {
    var data = ["Hello", "World"]
    var content : some View {
        NavigationStack {
            List {
                Section {
                    ForEach(data, id: \.self) { d in
                        Text(d)
                    }
                }
            }
            .welcomeUserNavTitle()
        }
    }
}

#Preview {
    HomeScreen()
        .previewContainer { b in
            b.transient(IAuthService.self, assigned(MockAuthService.self))
        } after: { c in
            c.resolve(UserContext.self).signIn()
        }
}

@ViewModel(generateEmpty: true)
final class HomeScreenViewModel {
    private var userContext: UserContext!
    
    func signOut() {
        userContext.signOut()
    }
}