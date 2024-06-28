//
//  Coordinator.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 15.05.24.
//

import UIKit

protocol Coordinator: AnyObject {
    var coordinators: [Coordinator] { get set }
}
