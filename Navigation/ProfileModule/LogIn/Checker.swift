//
//  Checker.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 22.04.24.
//

import UIKit
import FirebaseAuth

enum AuthResult {
    case success
    case failure(FirebaseError)
}

enum FirebaseError: Error, CustomStringConvertible {
    case noData
    case wrongData
    case emailAlreadyInUse
    case weakPassword
    case somthingWentWrong
    
    var description: String {
        switch self {
            
        case .noData:
            return "Не введены логин и(или) пароль"
        case .wrongData:
            return "Неверный логин или пароль"
        case .emailAlreadyInUse:
            return "email уже используется"
        case .weakPassword:
            return "слабый пароль"
        case .somthingWentWrong:
            return "Что-то пошло не так..."
        }
    }
}

protocol CheckerServiceProtocol {
    func checkCredentials(usersLogin: String, usersPassword: String, completion: @escaping ((AuthResult) -> Void)) -> Void
    func signUp(usersLogin: String, usersPassword: String, completion: @escaping ((AuthResult) -> Void)) -> Void
}

final class CheckerService: CheckerServiceProtocol {
    static let shared = CheckerService()
    
    func checkCredentials(usersLogin: String, usersPassword: String, completion: @escaping ((AuthResult) -> Void)) -> Void {
        
        guard usersLogin != "", usersPassword != "" else {
            completion(.failure(.noData))
            return
        }
        
        Auth.auth().signIn(withEmail: usersLogin, password: usersPassword) { result, error in
            if result?.user != nil {
                completion(.success)
            } else {
                completion(.failure(.wrongData))
                return
            }
        }
    }
    
    func signUp(usersLogin: String, usersPassword: String, completion: @escaping ((AuthResult) -> Void)) -> Void {
        
        guard usersLogin != "", usersPassword != "" else {
            completion(.failure(.noData))
            return
        }
        
        Auth.auth().createUser(withEmail: usersLogin, password: usersPassword) { result, error in
            
            if result?.user != nil {
                completion(.success)
            } else {
                if let error {
                    let err = error as NSError
                    switch err.code {
                    case AuthErrorCode.emailAlreadyInUse.rawValue:
                        completion(.failure(.emailAlreadyInUse))
                    case AuthErrorCode.weakPassword.rawValue:
                        completion(.failure(.weakPassword))
                    default:
                        ()
                    }
                    completion(.failure(.somthingWentWrong))
                }
            }
        }
    }
}
