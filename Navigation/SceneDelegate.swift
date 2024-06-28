//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 23.01.24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let mainCoordinator = MainCoordinator()


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: scene)
        window.rootViewController = mainCoordinator.tabBarController
        
//        let tabBarController = UITabBarController()
//        
//        let feedViewController = FeedViewController()
//        let logInViewController = LogInViewController()
//        
//        let feedNavigationController = UINavigationController(rootViewController: feedViewController)
//        let profileNavigationController = UINavigationController(rootViewController: logInViewController)
//        
//        tabBarController.viewControllers = [feedNavigationController, profileNavigationController]
//        
//        feedNavigationController.tabBarItem = UITabBarItem(title: "Лента", image: UIImage(systemName: "text.justify"), tag: 0)
//        profileNavigationController.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person.circle"), tag: 1)
//        
//        tabBarController.selectedIndex = 1
//        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        
        self.window = window
        
//        let factory = MyLoginFactory()
//        logInViewController.loginDelegate = factory.makeLoginInspector()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

