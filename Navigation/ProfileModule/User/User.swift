//
//  User.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 17.04.24.
//

import UIKit

final class User {
    var login: String
    var fullName: String
    var avatar: UIImage
    var status: String
    
    init(login: String, fullName: String, avatar: UIImage, status: String) {
        self.login = login
        self.fullName = fullName
        self.avatar = avatar
        self.status = status
    }
}
