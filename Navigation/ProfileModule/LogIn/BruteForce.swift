//
//  BruteForce.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 30.05.24.
//

import UIKit

extension String {
    var digits:      String { return "0123456789" }
    var lowercase:   String { return "abcdefghijklmnopqrstuvwxyz" }
    var uppercase:   String { return "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
    var punctuation: String { return "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~" }
    var letters:     String { return lowercase + uppercase }
    var lettersAndDigits:     String { return lowercase + uppercase + digits }
    var printable:   String { return digits + letters + punctuation }
    
    mutating func replace(at index: Int, with character: Character) {
        var stringArray = Array(self)
        stringArray[index] = character
        self = String(stringArray)
    }
}

class BruteForce {
    
    static var shared = BruteForce()
    
    var passwordToUnlock: String = ""
    
    func indexOf(character: Character, _ array: [String]) -> Int {
        return array.firstIndex(of: String(character))!
    }
    
    func characterAt(index: Int, _ array: [String]) -> Character {
        return index < array.count ? Character(array[index])
        : Character("")
    }
    
    func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
        var str: String = string
        
        if str.count <= 0 {
            str.append(characterAt(index: 0, array))
        }
        else {
            str.replace(at: str.count - 1,
                        with: characterAt(index: (indexOf(character: str.last!, array) + 1) % array.count, array))
            
            if indexOf(character: str.last!, array) == 0 {
                str = String(generateBruteForce(String(str.dropLast()), fromArray: array)) + String(str.last!)
            }
        }
        
        return str
    }
    
    func generatePassword() {
        
        let length = 4
        let ALLOWED_CHARACTERS:   [String] = String().lettersAndDigits.map { String($0) }
        
        passwordToUnlock = String((0..<length).compactMap{ _ in
            let character: Character = Character(ALLOWED_CHARACTERS.randomElement() ?? "")
            
            passwordToUnlock.append(character)
            return character
        })
        
    }
    
    func bruteForce(passwordToUnlock: String) -> String {
        let ALLOWED_CHARACTERS:   [String] = String().lettersAndDigits.map { String($0) }
        
        var password: String = ""
        
        while password != passwordToUnlock {
            password = generateBruteForce(password, fromArray: ALLOWED_CHARACTERS)
            
        }
        
        return password
    }
}

