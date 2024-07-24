//
//  Checker.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 22.04.24.
//

import UIKit
import FirebaseAuth

final class Checker {
    static let shared = Checker()
    
//    private let login: String = users[3].login
//    
//    private var password: String = "Alladin"

    
    func check(usersLogin: String, usersPassword: String) -> Void {
        
        print(usersLogin)
        print(usersPassword)
        
        guard usersLogin != "", usersPassword != "" else {
            return
        }
        
        Auth.auth().createUser(withEmail: usersLogin, password: usersPassword) { result, error in
            
            if let error {
                let err = error as NSError
                switch err.code {
                case AuthErrorCode.emailAlreadyInUse.rawValue:
                    print("email уже используется")
                    Auth.auth().signIn(withEmail: usersLogin, password: usersPassword) { result, error in
                        if result?.user != nil {
                            print("user is loged in")
                        } else {
                            print("not user")
                            return
                        }
                    }
                case AuthErrorCode.weakPassword.rawValue:
                    print("слабый пароль")
                default:
                    ()
                }
                print(error)
            }
            
        }
        
//        Auth.auth().signIn(withEmail: usersLogin, password: usersPassword) { result, error in
//            
//            if error == nil {
//                print("есть пользователь")
//                
//            } else {
//                print("Ошибка авторизации")
//                
//            }
//        }
//        return
        
//        Auth.auth().createUser(withEmail: usersLogin, password: usersPassword) { result, error in
//            
//            if let error {
//                let err = error as NSError
//                switch err.code {
//                case AuthErrorCode.emailAlreadyInUse.rawValue:
//                    Auth.auth().signIn(withEmail: usersLogin, password: usersPassword) { result, error in
//                        
//                        if result?.user != nil {
//                            authentication = true
//                        } else {
//                            authentication = false
//                        }
//                        
//                    }
//                default:
//                    ()
//                }
//            }
//            authentication = true
//            
//        }
    
        
//        return usersLogin == login && usersPassword == password
    }
}
