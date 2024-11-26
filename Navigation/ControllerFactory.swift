//
//  ControllerFactory.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 15.05.24.
//

import UIKit

protocol ControllerFactory {
    func makeFeed() -> (viewModel: FeedViewModel, controller: FeedViewController)
    
    func makeProfile() -> (viewModel: ProfileViewModel, controller: ProfileViewController)
    
    func makeSavedPosts() -> (viewModel: SavedPostsViewModel, controller: SavedPostsViewController)
}

struct ControllerFactoryImpl: ControllerFactory {
   
    func makeProfile() -> (viewModel: ProfileViewModel, controller: ProfileViewController) {
        let service = Service()
        let viewModel = ProfileViewModel(service: service)
        let controller = ProfileViewController(profileViewModel: viewModel)
        return (viewModel, controller)
    }
    
    
    func makeFeed() -> (viewModel: FeedViewModel, controller: FeedViewController) {
        let viewModel = FeedViewModel()
        let controller = FeedViewController(feedViewModel: viewModel)
        return (viewModel, controller)
    }
    
    func makeSavedPosts() -> (viewModel: SavedPostsViewModel, controller: SavedPostsViewController) {
        let viewModel = SavedPostsViewModel()
        let controller = SavedPostsViewController()
        return (viewModel, controller)
    }
    
}
