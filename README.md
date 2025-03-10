# Clerk Implementation in SwiftUI
## Todo

- [x] Create scaffolded project
- [x] Try to use Lambdaspire Dependency Injection
- [x] Refactor to Factory
- [x] Impldment basic sign-in and sign-out with Google SSO sign
- [x] Add on first render for root view ability to fetch current session/user.
- [x] Wire up dashboard screen with mock data
- [x] Get user context user updates without needing to sub to changes inside view model (just inject into view and view will update when changes occur on user).
- [ ] Scaffold data context and services (real and mock) to 'fetch' data.
- [ ] Implement actual 'API' to retrieve that data
- [ ] Try to get an API that has auth to verify token we get from clerk
- [ ] Add middleware onto api requests to get token from auth service
- [ ] Make sign-in pretty
- [ ] Make dashboard pretty
- [ ] Create hamburger button to popout modal with signout

## Summary
Inspired by the [Lambdaspire Foundations Project](https://github.com/Lambdaspire/Lambdaspire-SwiftUI-Foundations-Example), I wanted to try take this a bit further and implement an actual working auth service which fetches data from an API. The interesting things about the example above are it adds enough abstraction where I can easily swap out key pieces for mock implementations to help with testing/creating previews.

Another key feature is the concept of contexts, which are used to bridge the gap between implementation details of external dependencies and application state similar to React Query.

To that end I have chosen [Clerk](https://clerk.com/docs/quickstarts/ios) to act as my auth implementation. This was made on a whim and enitrely based on only good things I've seen and heard from work colleagues and prolific [Youtube personalities](https://youtu.be/lxslnp-ZEMw?si=ZVlwn2V1qvtwv_3d&t=1361)

## Getting Started
You will need to configure you Clerk application to enable the Native API. The setup can be found on the quickstart ios docs.

You will need to create a config.xcconfig file that has your Clerk publishable key, it should look like

```
CLERK_API_KEY = pk_test_xxxxxx
```
At this point you should be able to build and use the previews or run the app.

## Learnings
### Try to use Lambdaspire Dependency Injection (Ended up with Factory)

 I had trouble coercing my services but I wanted to inject the shared singleton instance publicly availble from Clerk, services that require that need to be marked with the @MainActor macro, I swapped to [Factory](https://github.com/hmlongco/Factory), this allowed me to where needed in previews or my container, mark my injected services like so

 ```swift
import Factory

extension Container {
    var auth: Factory<AuthService> {
        self { @MainActor in ClerkAuthService() }.singleton
    }
}
 ```

 I can then use the Clerk shared instance inside of my auth service like so:
```swift
import Clerk
@MainActor
public class ClerkAuthService: AuthService {
    
    
    private var clerk: Clerk = Clerk.shared
    
    func getCurrentUser()  -> User? {
        if clerk.session != nil {
            let user = clerk.user
            return .init(name: user?.firstName ?? "User")
        }
        
        return nil
    }
}
```
#### Dumping spot for things I don't know the reasoon or how to do
- get config working so it plays nice if I want to deploy this, right now I have to dump a config file into my build, itd be nice if i can commit the config but read in values from .env
- using @observable marco rather than ObservableObject exhibited some weird behaviour, idk why.
- what even is main actor and why do things need to be marked async
- pros-cons of having extensions of views for viewmodels (seems to be naming??)




