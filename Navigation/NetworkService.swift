//
//  NetworkService.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 9.07.24.
//

import Foundation

struct Answer {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
    
    init(json: [String: Any]) {
        userId = json["userId"] as? Int ?? 0
        id = json["id"] as? Int ?? 0
        title = json["title"] as? String ?? ""
        completed = json["completed"] as? Bool ?? true
    }
    
}

// MARK: - Planet
struct Planet: Decodable {
    let name, rotationPeriod, orbitalPeriod, diameter: String
    let climate, gravity, terrain, surfaceWater: String
    let population: String
    let residents, films: [String]
    let created, edited: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case name
        case rotationPeriod = "rotation_period"
        case orbitalPeriod = "orbital_period"
        case diameter, climate, gravity, terrain
        case surfaceWater = "surface_water"
        case population, residents, films, created, edited, url
    }
}

struct Resident: Decodable {
    let name, height, mass, hairColor: String
    let skinColor, eyeColor, birthYear, gender: String
    let homeworld: String
    let films: [String]
    let species: [String]
    let vehicles, starships: [String]
    let created, edited: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case name, height, mass
        case hairColor = "hair_color"
        case skinColor = "skin_color"
        case eyeColor = "eye_color"
        case birthYear = "birth_year"
        case gender, homeworld, films, species, vehicles, starships, created, edited, url
    }
}

struct NetworkService {
    
    func requestTitle(comletion: @escaping ((Result<String?, NetworkError>) -> Void)) {
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos/")!
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                comletion(.failure(.noInternet))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                comletion(.failure(.badResponse))
                return
            }
            
            if !((200..<300).contains(response.statusCode)) {
                comletion(.failure(.badStatusCode(response.statusCode, response.allHeaderFields)))
                return
            }
            
            guard let data else {
                comletion(.failure(.noData))
                return
            }
            
            do{
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: Any]]
                else {
                    return
                }
                let element = json[4]
                let answer = Answer(json: element)
                let title = answer.title
                comletion(.success(title))
            }
            catch{
                comletion(.failure(.somthingWentWrong))
                return
            }
        }
        task.resume()
    }
    
    func requestOrbitalPeriod(comletion: @escaping ((Result<String?, NetworkError>) -> Void)) {
        
        let url = URL(string: "https://swapi.dev/api/planets/1")!
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                comletion(.failure(.noInternet))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                comletion(.failure(.badResponse))
                return
            }
            
            if !((200..<300).contains(response.statusCode)) {
                comletion(.failure(.badStatusCode(response.statusCode, response.allHeaderFields)))
                return
            }
            
            guard let data else {
                comletion(.failure(.noData))
                return
            }
            
            do {let planet = try  JSONDecoder().decode(Planet.self, from: data)
                let orbitalPeriod = planet.orbitalPeriod
                comletion(.success(orbitalPeriod))
            }
            catch{
                comletion(.failure(.somthingWentWrong))
            }
        }
        task.resume()
    }
    
    func requestListOfResidents(comletion: @escaping ((Result<[String], NetworkError>) -> Void)) {
        
        let url = URL(string: "https://swapi.dev/api/planets/1")!
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                comletion(.failure(.noInternet))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                comletion(.failure(.badResponse))
                return
            }
            
            if !((200..<300).contains(response.statusCode)) {
                comletion(.failure(.badStatusCode(response.statusCode, response.allHeaderFields)))
                return
            }
            
            guard let data else {
                comletion(.failure(.noData))
                return
            }
            
            do {let planet = try  JSONDecoder().decode(Planet.self, from: data)
                let residents = planet.residents
                comletion(.success(residents))
                print("ListOfResidents - \(residents)")
            }
            catch{
                comletion(.failure(.somthingWentWrong))
            }
        }
        task.resume()
    }
    
    func requestResident(urlResident: String, comletion: @escaping ((Result<Resident?, NetworkError>) -> Void)) {
        
        let url = URL(string: urlResident)!
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                comletion(.failure(.noInternet))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                comletion(.failure(.badResponse))
                return
            }
            
            if !((200..<300).contains(response.statusCode)) {
                comletion(.failure(.badStatusCode(response.statusCode, response.allHeaderFields)))
                return
            }
            
            guard let data else {
                comletion(.failure(.noData))
                return
            }
            
            do {let resident = try  JSONDecoder().decode(Resident.self, from: data)
//                let name = resident.name
                comletion(.success(resident))
                print("Resident - \(resident)")
            }
            catch{
                comletion(.failure(.somthingWentWrong))
            }
        }
        task.resume()
    }
 
}
