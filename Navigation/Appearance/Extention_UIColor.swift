//
//  Extention_UIColor.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 31.10.24.
//

import UIKit

extension UIColor {
    static func createColor(darkColor: UIColor, anyColor: UIColor) -> UIColor {
        UIColor { triatCollection in
            if triatCollection.userInterfaceStyle == .dark {
                return darkColor
            } else {
                return anyColor
            }
            
        }
    }
}
