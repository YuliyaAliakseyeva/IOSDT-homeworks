//
//  SavedPostsCoordinator.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 4.10.24.
//

import UIKit
import StorageService

final class SavedPostsCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private var factory: ControllerFactory
    private lazy var savedPostsModule = {
        factory.makeSavedPosts()
    }()
        
        init(navigation: UINavigationController,
             factory: ControllerFactory) {
            self.navigationController = navigation
            self.factory = factory
        }
    
    func start() {
        showFeed()
    }
    
    func showFeed() {
        let viewModel = SavedPostsViewModel()
        let vc = SavedPostsViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
   

}
