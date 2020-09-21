//
//  UserViewModel.swift
//  SimpleRSSReader
//
//  Created by Gabriel on 20/09/2020.
//  Copyright © 2020 Gabriel. All rights reserved.
//

import WebKit

struct UserCodable: Codable {
    let user, password: String
}

class UserViewModel {
    private(set) var accessToken = ""
    private let networkManager = NetworkManager()
    
    func registerUser(username: String, password: String, completition: @escaping (_ errorMessage: String?)->()) {
        networkManager.registerUser(withUser: username, password: password) {[weak self] (result) in
            switch result{
            case .success(let user):
                self?.accessToken = user.accessToken
                completition(nil)
            case .failure(let error):
                completition(error.message)
            }
        }
    }
    
    func loginUser(username: String, password: String, completition: @escaping (_ errorMessage: String?)->()) {
        networkManager.loginUser(withUser: username, password: password) {[weak self] (result) in
            switch result{
            case .success(let user):
                self?.accessToken = user.accessToken
                completition(nil)
            case .failure(let error):
                completition(error.message)
            }
        }
    }
}







struct RSSFeedCodable: Codable {
    let url: String
}

struct RSSFeed: Decodable{
    var id: String
    var title: String
    var url: String
}

