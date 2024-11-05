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
    var user: User? { get set }
    var error: String? { get set }
    
    func userButtonPressed(loginVM: String, passwordVM: String, completion: @escaping () -> ()) -> Void
    func signUpButtonPressed(loginVM: String, passwordVM: String, completion: @escaping () -> ()) -> Void
    
    func biometricsButtonPressed(completion: @escaping () -> ())
}

final class LoginViewModel: LoginViewModelProtocol {
    
    var isLoggedIn = false
    var user: User?
    var error: String?
    
    var loginDelegate: LoginViewControllerDelegate?
    
    func userButtonPressed(loginVM: String, passwordVM: String, completion: @escaping () -> ()) -> Void {
        
        loginDelegate?.checkCredentials(login: loginVM, password: passwordVM) { [weak self] result in
            
            guard let self else {return}
            
            switch result {
            case .success:
                let userForProfile: UserService
                
                self.user = users.first(where: { $0.login == loginVM}) ?? User(login: loginVM, fullName: "", avatar: UIImage(systemName: "person.fill.questionmark")!, status: "")
                
#if DEBUG
                    userForProfile = TestUserService(user: users[1])
#else
                userForProfile = CurrentUserService(user: self.user!)
#endif
                
                self.user = users.first(where: { $0.login == loginVM}) ?? User(login: loginVM, fullName: loginVM, avatar: UIImage(systemName: "person")!, status: "")
                self.isLoggedIn = true
                print("юзер isLoggedIn - \(String(describing: Auth.auth().currentUser))")
                
            case .failure(let error):
                self.user = nil
                self.error = error.description
            }
            completion()
        }
    }
    
    func signUpButtonPressed(loginVM: String, passwordVM: String, completion: @escaping () -> ()) -> Void {
        
        loginDelegate?.signUp(login: loginVM, password: passwordVM) { [weak self] result in
            
            guard let self else {return}
            
            switch result {
            case .success:
            let userForProfile: UserService
                
                if let authUser = users.first(where: { $0.login == loginVM}) {
                    userForProfile = CurrentUserService(user: authUser)
                } else {
                    let profileUser = User(login: loginVM, fullName: loginVM, avatar: UIImage(systemName: "person.fill.questionmark")!, status: "")
                    
                    users.append(profileUser)
                
                    userForProfile = CurrentUserService(user: profileUser)
                }
            
            if let authUser = userForProfile.authorization(login: loginVM) {
                self.isLoggedIn = true
                self.user = authUser
                
            } else {
                self.isLoggedIn = false
                self.user = nil
                self.error = "Пользователь отсутствует в базе"
            }
            case .failure(let error):
                self.user = nil
                self.error = error.description
            }
            completion()
        }
    }
    
    func biometricsButtonPressed(completion: @escaping () -> ()) {
        self.user = users[2]
        self.isLoggedIn = true
        completion()
    }
}

