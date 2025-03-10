import Factory

//extension Container {
//    var auth: Factory<AuthService> {
//        self { @MainActor in ClerkAuthService() }.singleton
//    }
//    var userContext: Factory<UserContext> {
//        self { UserContext() }.singleton
//    }
//}

import LambdaspireAbstractions
import LambdaspireDependencyResolution

func getAppContainer() -> LambdaspireDependencyResolution.Container {
    
    let b: ContainerBuilder = .init()
    
    
    b.singleton(UserContext.self)
    
    b.singleton(AuthService.self, assigned(@MainActor in ClerkAuthService.self))
    
    return b.build()
}
