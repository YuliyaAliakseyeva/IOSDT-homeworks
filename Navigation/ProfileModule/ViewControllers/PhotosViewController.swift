//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 24.02.24.
//

import UIKit
import iOSIntPackage

final class PhotosViewController: UIViewController {
    
    var coordinator: ProfileCoordinator?
    
    var start: DispatchTime?
    var end: DispatchTime?
    
    //    fileprivate lazy var photosForGallery: [UIImage] = PhotoGallery.makeArrayOfUIImages()
    
    lazy var dataForGallery: [UIImage] = PhotoGallery.makeArrayOfUIImages() {
        didSet {
            DispatchQueue.main.async(execute: {self.photoCollectionView.reloadData()})
            self.end = DispatchTime.now()
            print("didSet")
            calculateTime(start: self.start!, end: self.end!)
        }
    }

    
    private lazy var photoCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: viewLayout
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.id)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupSubviews()
        setupLayouts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.tintColor = .systemBlue
        navigationBar?.barStyle = .default
        self.start = DispatchTime.now()
        processImages()
    }
    
    
    func processImages() {
        let filter = ImageProcessor()
        var array: [UIImage] = []

        filter.processImagesOnThread(sourceImages: dataForGallery, filter: .noir, qos: .background) { [weak self] images in
                for i in images {
                    let uiImage = UIImage(cgImage: i!)
                    array.append(uiImage)
                }
                self!.dataForGallery = array
            }
    }
    
    private func calculateTime(start: DispatchTime, end: DispatchTime) {
            let start = start
            let end = end
            let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
            let timeInterval = Double(nanoTime) / 1_000_000_000
            print("Time: \(timeInterval) seconds")
        }
    
    private func setupView() {
        view.backgroundColor = .systemGray6
        title = "Photo Gallery"
    }
    
    private func setupSubviews() {
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        view.addSubview(photoCollectionView)
        
        photoCollectionView.dataSource = self
        photoCollectionView.delegate = self
        
    }
    
    private func setupLayouts() {
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            photoCollectionView.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor
            ),
            photoCollectionView.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor
            ),
            photoCollectionView.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor
            ),
            photoCollectionView.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor
            ),
        ])
    }
    private enum LayoutConstant {
        static let spacing: CGFloat = 8.0
    }
    
}

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int)
    -> Int {
        dataForGallery.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath)
    -> UICollectionViewCell {
        let cell = photoCollectionView.dequeueReusableCell(
            withReuseIdentifier: PhotosCollectionViewCell.id,
            for: indexPath) as! PhotosCollectionViewCell
        
        let gallery = dataForGallery[indexPath.row]
        cell.configure(with: gallery)
        
        return cell
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    private func itemWidth(
        for width: CGFloat,
        spacing: CGFloat
    ) -> CGFloat {
        let itemsInRow: CGFloat = 3
        
        let totalSpacing: CGFloat = 2 * spacing + (itemsInRow - 1) * spacing
        let finalWidth = (width - totalSpacing) / itemsInRow
        
        return floor(finalWidth)
    }
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath)
    -> CGSize {
        let width = itemWidth(
            for: view.frame.width,
            spacing: LayoutConstant.spacing
        )
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int)
    -> UIEdgeInsets {
        UIEdgeInsets(
            top: LayoutConstant.spacing,
            left: LayoutConstant.spacing,
            bottom: LayoutConstant.spacing,
            right: LayoutConstant.spacing)
    }
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int)
    -> CGFloat {
        LayoutConstant.spacing
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int)
    -> CGFloat {
        LayoutConstant.spacing
    }
}

extension PhotosViewController: ImageLibrarySubscriber {
    func receive(images: [UIImage]) {
        dataForGallery = images
        photoCollectionView.reloadData()
    }
    
}
