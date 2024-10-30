//
//  MapCoordinator.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 27.10.24.
//

import UIKit
import StorageService

final class MapCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private var factory: ControllerFactory
    private lazy var mapModule = {
        factory.makeSavedPosts()
    }()
        
        init(navigation: UINavigationController,
             factory: ControllerFactory) {
            self.navigationController = navigation
            self.factory = factory
        }
    
    func start() {
        showMap()
    }
    
    func showMap() {
        let viewModel = MapViewModel()
        let vc = MapViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
   

}
