//
//  SavedPostsViewController.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 4.10.24.
//

import UIKit
import CoreData

class SavedPostsViewController: UIViewController {
    
    var coordinator: SavedPostsCoordinator?

    var viewModel: SavedPostsViewModelProtocol?
    
    var posts: [Post] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(
            frame: .zero,
            style: .grouped
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
    
        title = "Избранное"
        addSubvies()
        setupTableView()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        posts = CoreDataManager.shared.fetchPosts()
        tableView.reloadData()
        print(posts.count)
    }
    
    private func addSubvies() {
        view.addSubview(tableView)
    }

    override func viewWillLayoutSubviews() {
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor
            ),
            tableView.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor
            ),
            tableView.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor
            ),
            tableView.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor
            )
        ])
    }

    private func setupTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SavedPostsTableViewCell.self, forCellReuseIdentifier: SavedPostsTableViewCell.id)
        
    }
}

extension SavedPostsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        posts.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
       
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SavedPostsTableViewCell.id, for: indexPath) as? SavedPostsTableViewCell else {return UITableViewCell()
            }
            
            let post = posts[indexPath.row]
            cell.configure(with: post)
            
            return cell
       
        }
    
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath) {
            
        }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CoreDataManager.shared.deletePost(post: posts[indexPath.row])
            posts = CoreDataManager.shared.fetchPosts()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

