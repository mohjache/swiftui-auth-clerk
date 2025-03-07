
import Combine
import LambdaspireSwiftUIFoundations
import LambdaspireAbstractions
import LambdaspireDependencyResolution
import SwiftUI

@ViewWithViewModel
struct AuthScreen {
    var content: some View {
        VStack {
            Button {
                vm.signIn()
            } label: {
                Text("Sign In")
            }
        }
      
    }
}

#Preview {
    AuthScreen()
        .previewContainer { b in
            b.singleton(UserContext.self)
            b.singleton(IAuthService.self, assigned(MockAuthService.self))
        }
}

@ViewModel(generateEmpty: true)
final class AuthScreenViewModel {
    
    private var userContext: UserContext!
    
    func signIn() {
        userContext.signIn()
    }
    
}