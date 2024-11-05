//
//  LocalAuthorizationService.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 4.11.24.
//

import Foundation
import LocalAuthentication

final class LocalAuthorizationService {
    let laContext = LAContext()
    var error: NSError?
    var type: LABiometryType?

    
    func authorizeIfPossible(_ authorizationFinished: @escaping (Bool) -> Void) {
        if  laContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            laContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "To enter in app"
            ) { success, error in
                if let error = error {
                    print("Try another method, \(error.localizedDescription)")
                    authorizationFinished(false)
                    return
                } else {
                    print("Auth: \(success)")
                    authorizationFinished(true)
                    return
                }
                //            self.auth()
            }
        } else {
                print("There is not permission to use biometrics")
            }
        }
    
    
    func auth() {
        laContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "To enter in app"
        ) { success, error in
            if let error = error {
                print("Try another method, \(error.localizedDescription)")
                return
            } else {
                print("Auth: \(success)")
                return
            }
        }
    }
    
    func authorizationType() ->  LABiometryType {
        return laContext.biometryType
    }
}
