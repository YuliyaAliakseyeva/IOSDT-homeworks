//
//  Checker.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 22.04.24.
//

import UIKit

final class Checker {
    static let shared = Checker()
    
    private let login: String = users[3].login
    
    private var password: String = "Alladin"
    
    func check(usersLogin: String, usersPassword: String) -> Bool {
        return usersLogin == login && usersPassword == password
    }
}
