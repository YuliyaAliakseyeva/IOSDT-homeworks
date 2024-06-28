//
//  CustomButton.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 30.04.24.
//

import UIKit

final class CustomButton: UIButton {
    typealias Action = () -> Void
    
    var title: String
    var titleColor: UIColor
    var buttonAction: Action
    
    
    init(title: String, titleColor: UIColor = .white, action: @escaping Action ) {
        self.title = title
        self.titleColor = titleColor
        self.buttonAction = action
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.configuration = .filled()
        self.setTitle(title, for: .normal)
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
    }
    
    @objc private func buttonTapped() {
        self.buttonAction()
    }
}
