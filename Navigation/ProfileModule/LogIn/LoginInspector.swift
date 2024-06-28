//
//  LoginInspector.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 23.04.24.
//

import UIKit

struct LoginInspector: LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool {
        return Checker.shared.check(usersLogin: login, usersPassword: password)
    }
}
