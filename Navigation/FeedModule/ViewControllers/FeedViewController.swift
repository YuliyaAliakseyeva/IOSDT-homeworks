//
//  FeedViewController.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 23.01.24.
//

import UIKit
import StorageService

final class FeedViewController: UIViewController {
    
    private var feedViewModel: FeedViewModelProtocol?
    var coordinator: FeedCoordinator?
    
    private lazy var wordTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        field.textColor = .black
        field.backgroundColor = .white
        field.placeholder = "secret word"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: field.frame.height))
        field.leftViewMode = .always
        
        return field
    }()
    
    private lazy var status: UILabel = {
        let label = UILabel()
        label.text = "Статус проверки"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    
    private lazy var checkGuessButton = CustomButton(title: "Проверить пароль") { [unowned self] in
        guard let word = wordTextField.text else { return }
        if word != "" {
            feedViewModel?.check(word: word)
            self.status.text = feedViewModel?.text
            self.status.textColor = feedViewModel?.color
        }
    }
    
    private lazy var firstPostButton = CustomButton(title: "Перейти к посту 1") { [unowned self] in
        coordinator?.showPost()
    }
    
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private lazy var secondPostButton = CustomButton(title: "Перейти к посту 2") { [unowned self] in
        coordinator?.showPost()
    }
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.clipsToBounds = true
        
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .center
        stack.distribution = .equalSpacing
        
        stack.addArrangedSubview(self.wordTextField)
        stack.addArrangedSubview(self.status)
        stack.addArrangedSubview(self.checkGuessButton)
        stack.addArrangedSubview(self.firstPostButton)
        stack.addArrangedSubview(self.timerLabel)
        stack.addArrangedSubview(self.secondPostButton)
        
        return stack
    }()
    
    init(feedViewModel: FeedViewModel) {
        self.feedViewModel = feedViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        title = "Лента"
        
        view.addSubview(stackView)
        
        setupConstrains()
    }
    
    private func setupConstrains() {
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 15
            ),
            stackView.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -15
            ),
            stackView.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor,
                constant: 15
            ),
            stackView.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor,
                constant: -15)
        ])
    }
}





