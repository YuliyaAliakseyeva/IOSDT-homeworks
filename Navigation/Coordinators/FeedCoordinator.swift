//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 15.05.24.
//

import UIKit
import StorageService

final class FeedCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private var factory: ControllerFactory
    private lazy var feedModule = {
        factory.makeFeed()
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
        let viewModel = FeedViewModel()
        let vc = FeedViewController(feedViewModel: viewModel)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    func showPost() {
        let viewModel = PostViewModel()
        let postViewController = PostViewController(postViewModel: viewModel)
        postViewController.coordinator = self
        viewModel.firstPost = Post(title: "Первый пост")
        postViewController.titlePost = viewModel.firstPost?.title ?? ""
        navigationController.pushViewController(postViewController, animated: true)
    }
    
    func showInfo() {
        let networkService = NetworkService()
        let viewModel = InfoViewModel(networkService: networkService)
        let infoViewController = InfoViewController(viewModel: viewModel)
        infoViewController.coordinator = self
        infoViewController.modalTransitionStyle = .coverVertical
        infoViewController.modalPresentationStyle = .pageSheet
       
        navigationController.viewControllers.last?.present(infoViewController, animated: true)
    }

}
