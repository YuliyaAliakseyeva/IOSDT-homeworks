//
//  CustomButton2.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 3.03.24.
//

import UIKit

final class CustomButton2: UIButton {
    override var isHighlighted: Bool {
        didSet {
            if (isHighlighted) {
                alpha = 0.8
            } else {
                alpha = 1
            }
        }
    }
    override var isSelected: Bool {
        didSet {
            if (isSelected) {
                alpha = 0.8
            } else {
                alpha = 1
            }
        }
    }
}
