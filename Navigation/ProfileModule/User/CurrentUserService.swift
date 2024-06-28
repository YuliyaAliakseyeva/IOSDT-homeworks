//
//  CurrentUserService.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 17.04.24.
//

import UIKit

final class CurrentUserService: UserService {
    var user: User
    
    init(user: User) {
        self.user = user
    }
    
    func getUser() -> User { user }
}
