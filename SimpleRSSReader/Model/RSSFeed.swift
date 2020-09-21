//
//  RSSFeed.swift
//  SimpleRSSReader
//
//  Created by Gabriel on 21/09/2020.
//  Copyright © 2020 Gabriel. All rights reserved.
//

import Foundation

struct RSSFeedCodable: Codable {
    let url: String
}

struct RSSFeed: Decodable{
    var id: Int
    var title: String
    var url: String
}

