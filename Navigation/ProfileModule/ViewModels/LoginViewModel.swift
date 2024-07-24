//
//  LoginViewModel.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 18.05.24.
//

import Foundation
import UIKit
import FirebaseAuth

protocol LoginViewModelProtocol{
    var isLoggedIn: Bool { get set }
    
    func userButtonPressed(loginVM: String, passwordVM: String) -> User
}

final class LoginViewModel: LoginViewModelProtocol {
    
    var isLoggedIn = false
    
    var loginDelegate: LoginViewControllerDelegate?
    
    func userButtonPressed(loginVM: String, passwordVM: String) -> User {
        
        loginDelegate?.check(login: loginVM, password: passwordVM)
        
            let userForProfile: UserService
            
        let user = users.first { $0.login == loginVM}
    
#if DEBUG
        userForProfile = TestUserService(user: users[1])
#else
            userForProfile = CurrentUserService(user: user ?? User(login: "", fullName: "", avatar: UIImage(systemName: "person.fill.questionmark")!, status: ""))
#endif
            
            if let user = userForProfile.authorization(login: loginVM) {
                isLoggedIn = true
                return user
            } else {
                isLoggedIn = false
                return User(login: "", fullName: "", avatar: UIImage(systemName: "person.fill.questionmark")!, status: "")
            }
            
        }
        
    
}
