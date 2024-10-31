//
//  Exrension_Int.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 30.10.24.
//

import Foundation

extension Int {
    var amountOfLikes: String {
        pluralString(for: "numberOfLikes", count: self)
    }
    
    func pluralString(for key: String, count: Int) -> String {
        let format = NSLocalizedString(key, tableName: "Plurals", comment: "")
        return String(format: format, count)
    }
}
