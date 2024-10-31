//
//  PhotosForProfile.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 22.02.24.
//
import Foundation

struct PhotosForProfile {
    let title: String
    let photoOne: String
    let photoTwo: String
    let photoThree: String
    let photoFour: String
}

extension PhotosForProfile {
    static func make() -> [PhotosForProfile] {
        [PhotosForProfile(title: NSLocalizedString("Photos", comment: ""), photoOne: "Photo-1", photoTwo: "Photo-2", photoThree: "Photo-3", photoFour: "Photo-4")
        ]
    }
}
