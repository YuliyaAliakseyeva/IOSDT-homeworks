//
//  LoginFactory.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 25.04.24.
//

import UIKit

protocol LoginFactory {
    func makeLoginInspector() -> LoginInspector
}
