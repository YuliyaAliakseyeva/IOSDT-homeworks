//
//  InfoViewController.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 24.01.24.
//

import UIKit

final class InfoViewController: UIViewController {
    
    var coordinator: FeedCoordinator?
    var networkService = NetworkService()
    var residents = [ResidentModel]()
    var viewModel: InfoViewModelProtocol?
   
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "title"
        return label
    }()
    
    private lazy var orbitalPeriodLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "orbital period"
        return label
    }()
    
    private lazy var alertButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Оповещение", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
    
        return tableView
    }()
    
    init(viewModel: InfoViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemOrange
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        
        view.addSubview(titleLabel)
        view.addSubview(orbitalPeriodLabel)
        view.addSubview(alertButton)
        view.addSubview(tableView)
        
        setupConstrains()
        getTitle()
        getOrbitalPeriod()
        viewModel?.getinfo()
        bindViewModel()
        
        alertButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
    }
    
    private func bindViewModel() {
        viewModel?.stateChanger = { [weak self] state in
            
            guard let self else {return}
            switch state{
            case .loading:
                break
            case .loaded(let residents):
                self.residents = []
                self.residents = residents
                self.tableView.reloadData()
            case .error(let error):
                print(error)
            }
        }
    }
    
    private func getTitle() {
        self.networkService.requestTitle { [weak self] result in
            
            guard let self else {return}
            
            DispatchQueue.main.async {
                switch result {
                case .success(let title):
                    self.titleLabel.text = title
                    print("Title - \(title ?? "error")")
                case .failure(let error):
                    self.titleLabel.text = error.description
                    print("Ошибка - \(error.description)")
                }
            }
        }
    }
    
    private func getOrbitalPeriod() {
        self.networkService.requestOrbitalPeriod { [weak self] result in
            
            guard let self else {return}
            
            DispatchQueue.main.async {
                switch result {
                case .success(let text):
                    self.orbitalPeriodLabel.text = "Период обращения планеты Татуин вокруг своей звезды - \(text ?? "error")"
                case .failure(let error):
                    self.orbitalPeriodLabel.text = error.description
                }
            }
        }
        
    }
    
    private func setupConstrains() {
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
        
            titleLabel.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor,
                constant: 50
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 15
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -15
            ),
            titleLabel.centerXAnchor.constraint(
                equalTo: safeAreaLayoutGuide.centerXAnchor
            ),
            
            orbitalPeriodLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 50
            ),
            orbitalPeriodLabel.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 15
            ),
            orbitalPeriodLabel.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -15
            ),
            orbitalPeriodLabel.centerXAnchor.constraint(
                equalTo: safeAreaLayoutGuide.centerXAnchor
            ),
            
            
            alertButton.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 15
            ),
            alertButton.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -15
            ),
            alertButton.topAnchor.constraint(
                equalTo: orbitalPeriodLabel.bottomAnchor,
                constant: 50
            ),
            alertButton.heightAnchor.constraint(equalToConstant: 40),
            
            tableView.topAnchor.constraint(
                equalTo: alertButton.bottomAnchor, constant: 15
            ),
            tableView.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor
            ),
            tableView.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor
            ),
            tableView.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor
            )
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

extension InfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return residents.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var config = UIListContentConfiguration.cell()
        config.text = residents[indexPath.row].name
        cell.contentConfiguration = config
        return cell
    }
    
    
}
