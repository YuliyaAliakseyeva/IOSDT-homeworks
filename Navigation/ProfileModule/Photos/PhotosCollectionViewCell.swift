//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 24.02.24.
//

import UIKit

final class PhotosCollectionViewCell: UICollectionViewCell {
    static let id = "PhotosCollectionViewCell"
    
    private let photo: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupSubviews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        contentView.addSubview(photo)
    }
    
    private func setupLayouts() {
        NSLayoutConstraint.activate([
        photo.topAnchor.constraint(
            equalTo: contentView.topAnchor
        ),
        photo.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor
        ),
        photo.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor
        ),
        photo.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor
        ),
        ])
    }
    
    func configure(with data: UIImage) {
        photo.image = data
    }
}
