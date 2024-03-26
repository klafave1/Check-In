import UIKit

// Scene Delegate responsible for managing the app's UI scenes
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    // Function called when a new scene session is being created
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Ensure the scene is of type UIWindowScene
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // Instantiate the main view controller
        let viewController = ViewController()
        
        // Embed the view controller in a navigation controller
        let navigationController = UINavigationController(rootViewController: viewController)
        
        // Create a new window with the given window scene
        let window = UIWindow(windowScene: windowScene)
        
        // Set the root view controller of the window to the navigation controller
        window.rootViewController = navigationController
        
        // Set the window's frame to match the screen bounds
        window.frame = UIScreen.main.bounds
        
        // Set the window property to the newly created window
        self.window = window
        
        // Make the window visible
        window.makeKeyAndVisible()
    }
}

// Sources:
// https://developer.apple.com/documentation/uikit
// https://developer.apple.com/documentation/uikit/uiwindow
// https://developer.apple.com/documentation/uikit/uiwindowscene
