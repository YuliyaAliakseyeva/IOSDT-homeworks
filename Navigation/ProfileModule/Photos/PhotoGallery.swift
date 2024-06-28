//
//  PhotoGallery.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 24.02.24.
//
import UIKit

struct PhotoGallery {
    let photo: UIImage
}

extension PhotoGallery {
    
    static func makeArrayOfUIImages() -> [UIImage] {
        (1...20).map {UIImage(named: "Photo-\($0)")!}
    }
}

