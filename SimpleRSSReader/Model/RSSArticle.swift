//
//  RSSArticle.swift
//  SimpleRSSReader
//
//  Created by Gabriel on 21/09/2020.
//  Copyright © 2020 Gabriel. All rights reserved.
//

import Foundation

struct RSSArticle: Decodable{
    var id: Int
    var title: String
    var url: String
    var summary: String
    var content: String
    var date: String
    var readBy: [Int]
    var loaded: String
}
