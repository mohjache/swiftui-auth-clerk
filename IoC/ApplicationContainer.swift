import Factory

extension Container {
    var auth: Factory<AuthService> {
        self { @MainActor in ClerkAuthService() }.singleton
    }
    var userContext: Factory<UserContext> {
        self { UserContext() }.singleton
    }
}
