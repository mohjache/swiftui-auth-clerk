import Foundation

public enum ApplicationConfig {
    enum Keys {
        static let ClerkApiKey = "CLERK_API_KEY"
    }
    
    private static let infoDictionary : [String:Any] = { 
        guard let dictionary = Bundle.main.infoDictionary else {
            fatalError("Cannot load info plist")
        }
        return dictionary
    }()
    
    static let clerkApiKey : String = {
        guard let key = ApplicationConfig.infoDictionary[Keys.ClerkApiKey] as? String else {
            fatalError("Cannot load auth api key")
        }
        return key
    }()
                       
}
