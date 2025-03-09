import Clerk
import Factory
import SwiftUI
    
struct RootView: View {

    var body: some View {
        VStack {
            Text("Sign in")
        }
    }
    
}

extension RootView {
    class ViewModel : ObservableObject{
        @Injected(\.userContext) private var userContext
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        let _ = Container.shared.auth.register {@MainActor in MockAuthService() }
        let _ = Container.shared.userContext.register { UserContext() }
        RootView()
    }
}
