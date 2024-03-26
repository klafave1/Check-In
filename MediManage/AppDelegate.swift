import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // This function is called when the application finishes launching.
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Indicates that the application finished launching successfully.
        return true
    }

    // MARK: UISceneSession Lifecycle
    
    // This function creates a UISceneConfiguration object for a new scene session.
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Returns a UISceneConfiguration object with default settings.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    // This function is called when the application discards scene sessions.
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // This function is currently empty as no specific actions are required when discarding scene sessions.
    }
}

// Sources:
// https://developer.apple.com/documentation/uikit/uiapplicationdelegate
//https://developer.apple.com/documentation/uikit/app_and_environment/managing_your_app_s_life_cycle
