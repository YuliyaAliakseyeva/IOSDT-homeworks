//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 23.01.24.
//

import UIKit
import CoreData

final class ProfileViewController: UIViewController {
    
    var start: DispatchTime?
    var end: DispatchTime?
    
    private var profileViewModel: ProfileViewModelProtocol
    private var dataForPost: [PostForProfile] = []
    private var dataForPhotos = PhotosForProfile.make()
    var coordinator: ProfileCoordinator?
    var gestureDict : [NSValue: Int]  = [:]
    
    var user: User?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(
            frame: .zero,
            style: .grouped
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
            let indicator = UIActivityIndicatorView(style: .medium)
            indicator.translatesAutoresizingMaskIntoConstraints = false
            return indicator
    }()
    
    init(profileViewModel: ProfileViewModel) {
        self.profileViewModel = profileViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
#if DEBUG
        view.backgroundColor = .red
#else
        view.backgroundColor = .green
#endif
        
        addSubviews()
        viewWillLayoutSubviews()
        setupTableView()
        bindViewModel()
        profileViewModel.changeStateIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
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
            ),
            
            activityIndicator.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 150
                                                      )
        ])
    }
    
    private func setupTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.id)
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.id)
        //        tableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: ProfileHeaderView.id)
    }
    
    private func bindViewModel() {
        self.start = DispatchTime.now()
        profileViewModel.currentState = { [weak self] state in
            guard let self else { return }
            
            switch state {
            case .initial:
                print("initial")
            case .loading:
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    tableView.isHidden = true
                    activityIndicator.isHidden = false
                    activityIndicator.startAnimating()
                }
            case .loaded(let posts):
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.dataForPost = posts
                    tableView.isHidden = false
                    tableView.reloadData()
                    activityIndicator.isHidden = true
                    activityIndicator.stopAnimating()
                }
            case .error:
                print("error")
            }
        }
        self.end = DispatchTime.now()
        calculateTime(start: self.start!, end: self.end!)
    }
    
    private func calculateTime(start: DispatchTime, end: DispatchTime) {
            let start = start
            let end = end
            let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
            let timeInterval = Double(nanoTime) / 1_000_000_000
            print("Time: \(timeInterval) seconds")
        }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(
        in tableView: UITableView
    ) -> Int {
        2
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        if section == 0 {
            return dataForPhotos.count
        } else if section == 1 {
            return dataForPost.count
        } else {
            return 0
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.id, for: indexPath) as? PhotosTableViewCell else {return UITableViewCell()
            }
            
            let photo = dataForPhotos[indexPath.row]
            cell.configure(with: photo)
            
            return cell
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.id, for: indexPath) as? PostTableViewCell else {return UITableViewCell()
            }
            
//            let tap = UITapGestureRecognizer()
//            tap.numberOfTapsRequired = 2
//            tap.addTarget(self, action: #selector(doubleTappedCell))
//            cell.isUserInteractionEnabled = true
//            cell.addGestureRecognizer(tap)
            
            
            let post = dataForPost[indexPath.row]
            cell.configure(with: post)
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
//    @objc func doubleTappedCell(_ gesture: UIPanGestureRecognizer) {
//        print("doubleTappedCell")
//        let key = NSValue.init(nonretainedObject: gesture)
//                guard let row = gestureDict[key] else {return}
//                print("row - \(row)")
//                let indexPath = IndexPath(row: row, section: 0)
//        print("indexPath - \(indexPath)")
//        let post = dataForPost[indexPath.row]
//        print("post - \(post)")
//        CoreDataManager.shared.addPost(author: post.author, text: post.description, image: post.image, likes: post.likes, views: post.views)
//    }
//    
    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        if section == 0 {
            220.0
        } else {
            0.0
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        if section == 0 {
            let headerView = ProfileHeaderView()
            headerView.avatarImageView.image = user?.avatar
            headerView.statusLabel.text = user?.status
            headerView.fullNameLabel.text = user?.fullName
            return headerView
        } else {
            return nil
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath) {
            if indexPath.section == 0 {
                coordinator?.showPhotos()
            }
        }
}
