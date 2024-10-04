//
//  LoginInspector.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 23.04.24.
//

import UIKit
import FirebaseAuth

struct LoginInspector: LoginViewControllerDelegate {
    
    func checkCredentials(login: String, password: String, completion: @escaping ((AuthResult) -> Void)) -> Void {
        return CheckerService.shared.checkCredentials(usersLogin: login, usersPassword: password, completion: completion)
    }
    func signUp(login: String, password: String, completion: @escaping ((AuthResult) -> Void)) -> Void {
        return CheckerService.shared.signUp(usersLogin: login, usersPassword: password, completion: completion)
    }
}
