//
//  UserService.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 17.04.24.
//

import UIKit

protocol UserService {
    var user: User {get set}
    func authorization (login: String) -> User?
}

extension UserService {
    func authorization(login: String) -> User? {
        return user.login == login ? user : nil
    }
}
