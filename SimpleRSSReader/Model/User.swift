//
//  User.swift
//  SimpleRSSReader
//
//  Created by Gabriel on 20/09/2020.
//  Copyright © 2020 Gabriel. All rights reserved.
//

import Foundation

struct UserCodable: Codable {
    let user, password: String
}

struct User: Decodable {
    var accessToken: String
    var userId: Int?
}
