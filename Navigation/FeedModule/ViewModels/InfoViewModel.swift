//
//  InfoViewModel.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 13.07.24.
//
import Foundation

protocol InfoViewModelProtocol {
    var stateChanger: ((InfoViewModel.StateNetworkService) -> Void)? {get set}
    func getinfo()
    
}

final class InfoViewModel: InfoViewModelProtocol {
    
    enum StateNetworkService {
        case loading
        case loaded([ResidentModel])
        case error(String)
    }
    
    private lazy var state: StateNetworkService = .loading {
        didSet {
            self.stateChanger?(state)
        }
    }
    
    var stateChanger: ((StateNetworkService) -> Void)?
    
    private var residents = [ResidentModel]()
    private var networkService: NetworkService
    
    var arrayOfUrls = [String]()
    
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getinfo() {
        
        state = .loading
        
        networkService.requestListOfResidents { [weak self] result in
            guard let self else {return}
            
            switch result {
            case .success(let urls):
                arrayOfUrls = urls
                
                var arrayOfResidents = [Resident]()
                
                for i in arrayOfUrls {
                    networkService.requestResident(urlResident: i) { [weak self] result in
                        
                        guard let self else {return}
                        
                        switch result {
                        case .success(let resident):
                            arrayOfResidents.append(resident!)
                        case .failure(let error):
                            print(error.description)
                        }
                        
                        let nameOfResidents = arrayOfResidents.map { resident in ResidentModel(resident: resident) }
                        residents = nameOfResidents
                        DispatchQueue.main.async { [weak self] in
                            self!.state = .loaded(nameOfResidents)
                        }
                    }
                }
            case .failure(let error):
                arrayOfUrls = [error.description]
                state = .error("Error")
            }
        }
    }
}


