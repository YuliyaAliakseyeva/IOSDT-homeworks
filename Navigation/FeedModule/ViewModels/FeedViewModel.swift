//
//  FeedViewModel.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 18.05.24.
//

import Foundation
import UIKit

protocol FeedViewModelProtocol{
    var model: FeedModel { get set }
    var text: String { get  }
    var color: UIColor? { get }
    
    func check(word: String)
}

final class FeedViewModel: FeedViewModelProtocol {
    var model = FeedModel(secretWord: "Voldemort")
    var text: String = ""
    var color: UIColor?
    
    func check(word: String) {
        if word == model.secretWord {
            self.text = "Верно"
            self.color = .green
        } else {
            self.text = "Неверно"
            self.color = .red
        }
    }
}
