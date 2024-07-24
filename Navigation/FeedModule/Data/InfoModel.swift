//
//  InfoModel.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 13.07.24.
//

import UIKit

struct Residents {
    
    var residents: [ResidentModel]
    
    init(residents: [ResidentModel]) {
        self.residents = residents
    }
}

struct ResidentModel {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

extension ResidentModel {
    init(resident: Resident) {
        self.name = resident.name
    }
}
