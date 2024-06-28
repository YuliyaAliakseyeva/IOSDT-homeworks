//
//  LoginViewModel.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 18.05.24.
//

import Foundation
import UIKit

protocol LoginViewModelProtocol{
    var isLoggedIn: Bool { get set }
    
    func userButtonPressed(loginVM: String, passwordVM: String) -> User
}

final class LoginViewModel: LoginViewModelProtocol {
    
    var isLoggedIn = false
    
    var loginDelegate: LoginViewControllerDelegate?
    
    func userButtonPressed(loginVM: String, passwordVM: String) -> User {
        
        let match = loginDelegate?.check(login: loginVM, password: passwordVM)
        let userForProfile: UserService
#if DEBUG
        userForProfile = TestUserService(user: users[2])
#else
        userForProfile = CurrentUserService(user: users[3])
#endif
        if let user = userForProfile.authorization(login: loginVM), match == true {
            isLoggedIn = true
            return user
        } else {
            isLoggedIn = false
            return User(login: "", fullName: "", avatar: UIImage(systemName: "person.fill.questionmark")!, status: "")
        }
    }
}
