import Factory

extension Container {
    var auth: Factory<AuthService> {
        self { @MainActor in ClerkAuthService() }.singleton
    }
    var api: Factory<ApiService> {
        self { RealApiService() }
    }

    var userContext: Factory<UserContext> {
        self { UserContext() }.singleton
    }
    var dataContext: Factory<DataContext> {
        self { DataContext() }
    }
}
