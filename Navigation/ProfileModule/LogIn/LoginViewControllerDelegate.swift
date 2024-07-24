//
//  LoginViewControllerDelegate.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 22.04.24.
//

import UIKit

protocol LoginViewControllerDelegate {
    
    func check(login: String, password: String) -> Void
}
