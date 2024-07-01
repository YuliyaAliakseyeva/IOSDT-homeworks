//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 15.05.24.
//

import UIKit

class MainCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    let networkManager = NetworkManager(config: .three)
    let tabBarController: TabBarController
    private let factory = ControllerFactoryImpl()
    
    init() {
        tabBarController = TabBarController(networkManager: networkManager)
        let profileCoordinator = configureProfile()
        let feedCoordinator = configureFeed()
        coordinators.append(profileCoordinator)
        coordinators.append(feedCoordinator)
        
        tabBarController.viewControllers = [profileCoordinator.navigationController, feedCoordinator.navigationController]
        profileCoordinator.start()
        feedCoordinator.start()
    }
    
    private func configureProfile() -> ProfileCoordinator {
        
        let navigationProfile = UINavigationController()
        navigationProfile.tabBarItem = UITabBarItem(
            title: "Профиль",
            image: UIImage(systemName: "person.circle"),
            tag: 1)
        let coordinator = ProfileCoordinator(
            navigation: navigationProfile,
            factory: factory)
        
        return coordinator
    }
    
    private func configureFeed() -> FeedCoordinator {
        
        let navigationFeed = UINavigationController()
        navigationFeed.tabBarItem = UITabBarItem(
            title: "Лента",
            image: UIImage(systemName: "text.justify"),
            tag: 0)
        let coordinator = FeedCoordinator(
            navigation: navigationFeed,
            factory: factory)
        
        return coordinator
    }
}
