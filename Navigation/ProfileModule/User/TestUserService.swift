//
//  TestUserService.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 18.04.24.
//

import UIKit

final class TestUserService: UserService {
    internal var user: User
    
    init(user: User) {
        self.user = user
    }
    
    func getUser() -> User { user }
}
