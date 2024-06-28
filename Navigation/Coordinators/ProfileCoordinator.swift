//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 15.05.24.
//

import UIKit

final class ProfileCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private var factory: ControllerFactory
    
    
    var isLoggedIn: Bool = false
    var user: User?
    
    init(navigation: UINavigationController,
         factory: ControllerFactory) {
        self.navigationController = navigation
        self.factory = factory
    }
    
    func start() {
        if isLoggedIn {
            showProfile()
        } else {
            showLogin()
        }
    }
    
    func showLogin() {
        let viewModel = LoginViewModel()
        let vc = LogInViewController(viewModel: viewModel)
        let factory = MyLoginFactory()
        viewModel.loginDelegate = factory.makeLoginInspector()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showProfile() {
        let service = Service()
        let viewModel = ProfileViewModel(service: service)
        let vc = ProfileViewController(profileViewModel: viewModel)
        vc.user = self.user
        vc.coordinator = self
        
        navigationController.viewControllers.removeAll()
        navigationController.pushViewController(vc, animated: true)
        
    }
    
    func showPhotos() {
        let photosViewController = PhotosViewController()
        photosViewController.coordinator = self
        navigationController.pushViewController(photosViewController, animated: true)
    }
}

