//
//  PostViewModel.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 18.05.24.
//

import Foundation
import StorageService

protocol PostViewModelProtocol {
    var firstPost: Post? { get set }
}

final class PostViewModel: PostViewModelProtocol {
    var firstPost: StorageService.Post?
    
}
