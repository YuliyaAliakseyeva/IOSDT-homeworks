//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 20.02.24.
//

import UIKit

final class PhotosTableViewCell: UITableViewCell {
    
    static let id = "PhotosTableViewCell"
    
    private let photosLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let photoView1: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let photoView2: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let photoView3: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let photoView4: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.clipsToBounds = true
        
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .fill
        stack.distribution = .fillEqually
          
        return stack
    }()
    
    private let arrow: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?) {
            super.init(
                style: .default,
                reuseIdentifier: reuseIdentifier
            )
            
            setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with data: PhotosForProfile) {
        photosLabel.text = data.title
        photoView1.image = UIImage(named: data.photoOne)
        photoView2.image = UIImage(named: data.photoTwo)
        photoView3.image = UIImage(named: data.photoThree)
        photoView4.image = UIImage(named: data.photoFour)
        arrow.image = UIImage(systemName: "arrow.right")
    }
    
    private func setupUI() {
        contentView.addSubview(photosLabel)
        contentView.addSubview(stackView)
        contentView.addSubview(arrow)
        
        stackView.addArrangedSubview(self.photoView1)
        stackView.addArrangedSubview(self.photoView2)
        stackView.addArrangedSubview(self.photoView3)
        stackView.addArrangedSubview(self.photoView4)
        
        NSLayoutConstraint(item: photoView1, attribute: .width, relatedBy: .equal, toItem: contentView, attribute: .width, multiplier: -4, constant: -12).isActive = true
        
        NSLayoutConstraint(item: photoView1, attribute: .height, relatedBy: .equal, toItem: photoView1, attribute: .width, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint.activate([
            photosLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 12
            ),
            photosLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 12
            ),
            photosLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -50
            ),
            
            photoView2.widthAnchor.constraint(
                equalTo: photoView1.widthAnchor
            ),
            photoView2.heightAnchor.constraint(
                equalTo: photoView1.heightAnchor
            ),

            photoView3.widthAnchor.constraint(
                equalTo: photoView1.widthAnchor
            ),
            photoView3.heightAnchor.constraint(
                equalTo: photoView1.heightAnchor
            ),

            photoView4.widthAnchor.constraint(
                equalTo: photoView1.widthAnchor
            ),
            photoView4.heightAnchor.constraint(
                equalTo: photoView1.heightAnchor
            ),
            
            stackView.topAnchor.constraint(
                equalTo: photosLabel.bottomAnchor,
                constant: 12
            ),
            stackView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -12
            ),
            stackView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 12
            ),
            stackView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -12
            ),
            
            arrow.centerYAnchor.constraint(
                equalTo: photosLabel.centerYAnchor
            ),
            arrow.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -12
            ),
            arrow.widthAnchor.constraint(
                equalToConstant: 24
            ),
            arrow.heightAnchor.constraint(
                equalTo: arrow.widthAnchor
            ),
        ])
        
        photosLabel.textColor = ColorManager.blackBacground
        photosLabel.font = .systemFont(ofSize: 24, weight: .bold)
        
        photoView1.layer.cornerRadius = 6
        photoView1.clipsToBounds = true
        
        photoView2.layer.cornerRadius = 6
        photoView2.clipsToBounds = true
        
        photoView3.layer.cornerRadius = 6
        photoView3.clipsToBounds = true
        
        photoView4.layer.cornerRadius = 6
        photoView4.clipsToBounds = true
        
        arrow.tintColor = ColorManager.blackBacground
    }
    
   
}
