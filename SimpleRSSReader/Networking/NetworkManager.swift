//
//  NetworkManager.swift
//  SimpleRSSReader
//
//  Created by Gabriel on 21/09/2020.
//  Copyright © 2020 Gabriel. All rights reserved.
//

import WebKit

struct Message: Decodable {
    var message: String
}

class NetworkManager {
    typealias UserCompletition = (Result<User,NetworkError>) -> ()
    
    private func prepareBodyJson<T: Encodable>(codable: T) -> Data? {
        var jsonData: Data
        do {
            jsonData = try JSONEncoder().encode(codable)
        } catch _{
            return nil
        }
        
        return jsonData
    }
    
    func registerUser(withUser username: String, password: String, completition: @escaping UserCompletition) {
        logInOrRegisterRequest(endpoint: .register, username: username, password: password, completition: completition)
    }
    
    func loginUser(withUser username: String, password: String, completition: @escaping UserCompletition) {
        logInOrRegisterRequest(endpoint: .logIn, username: username, password: password, completition: completition)
    }
    
    private func logInOrRegisterRequest(endpoint: Endpoints, username: String, password: String, completition: @escaping (Result<User,NetworkError>) -> ()) {
        guard let url = endpoint.url else { fatalError() }
        let httpMethod = endpoint.httpMethod
        let loginCodable = UserCodable(user: username, password: password)
        
        guard let body = prepareBodyJson(codable: loginCodable) else {
            completition(.failure(.wrongBodyFormat))
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = httpMethod
        request.httpBody = body
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
            
        session.dataTask(with: request) { (data, response, error) in
            if let _ = error { completition(.failure(.requestError)); return}
            
            guard let data = data else {
                completition(.failure(.nilDataResponseError))
                return
            }
            
            let response = NetworkResponse(data: data)
            guard let decodedUser = response.decode(User.self) else {
                if let decodedMessage = response.decode(Message.self) {
                    completition(.failure(.serverMessage(message: decodedMessage.message)))
                }
                completition(.failure(.decodingError))
                return
            }
            
            completition(.success(decodedUser))
            
        }.resume()
    }
}
