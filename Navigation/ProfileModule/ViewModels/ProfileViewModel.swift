//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 7.05.24.
//

import Foundation

enum State {
    case initial
    case loading
    case loaded([PostForProfile])
    case error
}
protocol ProfileViewModelProtocol {
    var state: State { get set }
    var currentState: ((State) -> Void)? { get set }
    func changeStateIfNeeded()
}

final class ProfileViewModel: ProfileViewModelProtocol {
    
    private let service: Service
    
    var state: State = .initial {
        didSet {
            currentState?(state)
        }
    }
    
    var currentState: ((State) -> Void)?
    
    init(service: Service) {
        self.service = service
    }
    
    func changeStateIfNeeded() {
        state = .loading
        service.fetchPosts { result in
            switch result {
            case .success(let loadPosts):
                self.state = .loaded(loadPosts)
            case .failure(_):
                self.state = .error
            }
        }
    }
}



