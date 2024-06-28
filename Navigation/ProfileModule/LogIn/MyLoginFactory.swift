//
//  MyLoginFactory.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 25.04.24.
//

import UIKit

struct MyLoginFactory: LoginFactory {
    func makeLoginInspector() -> LoginInspector {
        LoginInspector()
    }
}
