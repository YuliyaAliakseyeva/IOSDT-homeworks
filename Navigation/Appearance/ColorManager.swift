//
//  ColorManager.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 1.11.24.
//

import UIKit

final class ColorManager {
    static var whiteBacground = UIColor { traitCollection in
        if traitCollection.userInterfaceStyle == .dark {
            return .black
        } else {
            return .white
        }
    }
    
    static var blackBacground = UIColor { traitCollection in
        if traitCollection.userInterfaceStyle == .dark {
            return .white
        } else {
            return .black
        }
    }
    
    static var blackBorder = UIColor { traitCollection in
        if traitCollection.userInterfaceStyle == .dark {
            return .lightGray
        } else {
            return .black
        }
    }
    
    static var whiteBorder = UIColor { traitCollection in
        if traitCollection.userInterfaceStyle == .dark {
            return .lightGray
        } else {
            return .white
        }
    }
    
    static var grayText = UIColor { traitCollection in
        if traitCollection.userInterfaceStyle == .dark {
            return .lightGray
        } else {
            return .darkGray
        }
    }
}
