//
//  InfoViewController.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 24.01.24.
//

import UIKit

final class InfoViewController: UIViewController {
    
    var coordinator: FeedCoordinator?
    
    private lazy var alertButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Оповещение", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemOrange
        
        view.addSubview(alertButton)
        setupConstrains()
        
        alertButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
    }
    
    private func setupConstrains() {
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            alertButton.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 15
            ),
            alertButton.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -15
            ),
            alertButton.centerYAnchor.constraint(
                equalTo: safeAreaLayoutGuide.centerYAnchor
            ),
            alertButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Справка", message: "Сохранить в избранное?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Да", style: .default, handler: {action in print("Пост сохранен в избранное")
        }))
        alert.addAction(UIAlertAction(title: "Нет", style: .default, handler: {action in print("Пост не сохранен в избранное")
        }))
        
        alert.modalTransitionStyle = .flipHorizontal
        alert.modalPresentationStyle = .pageSheet
        
        present(alert, animated: true)
    }
}
