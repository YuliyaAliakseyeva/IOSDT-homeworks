//
//  NetworkManager.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 28.06.24.
//

import Foundation

enum AppConfiguration {
    case one
    case two
    case three
    
    var url: URL {
        switch self {
            
        case .one:
            return URL(string: "https://swapi.dev/api/people/8")!
        case .two:
            return URL(string: "https://swapi.dev/api/starships/3")!
        case .three:
            return URL(string: "https://swapi.dev/api/planets/5")!
        }
    }
}

enum NetworkError: Error, CustomStringConvertible {
    case noInternet
    case badResponse
    case badStatusCode(Int, [AnyHashable : Any])
    case noData
    case somthingWentWrong
    
    var description: String {
        switch self {
            
        case .noInternet:
            return "Нет интернета"
        case .badResponse:
            return "Неверный ответ сервера"
        case .badStatusCode(let code, let allHeaderFields):
            return "Код ошибки - \(code), \(allHeaderFields)"
        case .noData:
            return "Нет данных"
        case .somthingWentWrong:
            return "Что-то пошло не так..."
        }
    }
}

struct NetworkManager {
    
    var config: AppConfiguration
    
    init(config: AppConfiguration) {
        self.config = config
    }
    
    func request(completion: @escaping ((Result<String?,NetworkError>) -> Void)) {
        
        let session = URLSession.shared
        let task = session.dataTask(with: config.url) { data, response, error in
            if error != nil {
                completion(.failure(.noInternet))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.badResponse))
                return
            }
            
            if !((200..<300).contains(response.statusCode)) {
                completion(.failure(.badStatusCode(response.statusCode, response.allHeaderFields)))
                return
            }
            
            guard let data else {
                completion(.failure(.noData))
                return
            }
            
            do{
                guard let answer = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    return
                }
                
                let name = answer["name"] as? String
                completion(.success(name))
                
            } catch {
                completion(.failure(.somthingWentWrong))
            }
        }
        task.resume()
    }
}
