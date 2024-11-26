//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 15.05.24.
//

import UIKit

class MainCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    let networkManager = NetworkService(config: .three)
    let tabBarController: TabBarController
    private let factory = ControllerFactoryImpl()
    
    init() {
        tabBarController = TabBarController(networkManager: networkManager)
        let profileCoordinator = configureProfile()
        let feedCoordinator = configureFeed()
        let savedPostsCoordinator = configureSavedPosts()
        let mapCoordinator = configureMap()
        coordinators.append(profileCoordinator)
        coordinators.append(feedCoordinator)
        coordinators.append(savedPostsCoordinator)
        coordinators.append(mapCoordinator)
        
        tabBarController.viewControllers = [profileCoordinator.navigationController, feedCoordinator.navigationController, savedPostsCoordinator.navigationController, mapCoordinator.navigationController]
        profileCoordinator.start()
        feedCoordinator.start()
        savedPostsCoordinator.start()
        mapCoordinator.start()
    }
    
    private func configureProfile() -> ProfileCoordinator {
        
        let navigationProfile = UINavigationController()
        navigationProfile.tabBarItem = UITabBarItem(
            title: NSLocalizedString("Profile", comment: ""),
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
            title: NSLocalizedString("Feed", comment: ""),
            image: UIImage(systemName: "text.justify"),
            tag: 0)
        let coordinator = FeedCoordinator(
            navigation: navigationFeed,
            factory: factory)
        
        return coordinator
    }
    
    private func configureSavedPosts() -> SavedPostsCoordinator {
        
        let navigationSavedPosts = UINavigationController()
        navigationSavedPosts.tabBarItem = UITabBarItem(
            title: NSLocalizedString("Favorites", comment: ""),
            image: UIImage(systemName: "star.fill"),
            tag: 0)
        let coordinator = SavedPostsCoordinator(
            navigation: navigationSavedPosts,
            factory: factory)
        
        return coordinator
    }
    
    private func configureMap() -> MapCoordinator {
        
        let navigationMap = UINavigationController()
        navigationMap.tabBarItem = UITabBarItem(
            title: NSLocalizedString("Map", comment: ""),
            image: UIImage(systemName: "map"),
            tag: 0)
        let coordinator = MapCoordinator(
            navigation: navigationMap,
            factory: factory)
        
        return coordinator
    }
}
