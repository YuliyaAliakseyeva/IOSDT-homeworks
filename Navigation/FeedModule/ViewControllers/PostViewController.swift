//
//  PostViewController.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 24.01.24.
//

import UIKit

final class PostViewController: UIViewController {
    
    var coordinator: FeedCoordinator?
    
    private var postViewModel: PostViewModelProtocol?
    var titlePost: String = "None"
    
    init(postViewModel: PostViewModelProtocol) {
        self.postViewModel = postViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemMint
        title = titlePost
        
        let infoBarButton = UIBarButtonItem(title: "Инфо", style: .done, target: self, action: #selector(pressedButton))
        
        navigationItem.rightBarButtonItem = infoBarButton
    }
    
    @objc func pressedButton () {
        coordinator?.showInfo()
    }
}
