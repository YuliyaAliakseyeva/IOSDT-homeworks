//
//  LoginViewControllerDelegate.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 22.04.24.
//

import UIKit
import FirebaseAuth

protocol LoginViewControllerDelegate {
    
    func checkCredentials(login: String, password: String, completion: @escaping ((AuthResult) -> Void)) -> Void
    
    func signUp(login: String, password: String, completion: @escaping ((AuthResult) -> Void)) -> Void
}
