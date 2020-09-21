//
//  Endpoints.swift
//  SimpleRSSReader
//
//  Created by Gabriel on 20/09/2020.
//  Copyright © 2020 Gabriel. All rights reserved.
//

import Foundation

enum Endpoints {
    case logIn
    case register
    case subscribeRSSFeed
    case getRSSFeeds
    case getRSSFeedArticles(feedId: String)
    case updateRSSFeed(feedId: String)
    case deleteRSSFeed(feedId: String)
    case toggleReadArticle(feedId: String, articleId: String)
    
    var url: URL?{
        let host = "167.99.162.146"
        
        var components = URLComponents()
        components.scheme = "http"
        components.host = host
        
        switch self {
        case .logIn:
            components.path = "/users/login"
        case .register:
            components.path = "/users/register"
        case .subscribeRSSFeed:
            components.path = "/feeds/add"
        case .getRSSFeeds:
            components.path = "/feeds"
        case .getRSSFeedArticles(feedId: let feedId):
            components.path = "/feeds/\(feedId)/articles"
        case .updateRSSFeed(feedId: let feedId):
            components.path = "/feeds/\(feedId)/refresh"
        case .deleteRSSFeed(feedId: let feedId):
            components.path = "/feeds/\(feedId)"
        case .toggleReadArticle(feedId: let feedId, articleId: let articleId):
            components.path = "/feeds/\(feedId)/articles/\(articleId)/toggle_read"
        }
        
        return components.url
    }
    
    var httpMethod: String {
        switch self {
        case .logIn:
            return "POST"
        case .register:
            return "POST"
        case .subscribeRSSFeed:
            return "POST"
        case .getRSSFeeds:
            return "GET"
        case .getRSSFeedArticles(feedId: _):
            return "GET"
        case .updateRSSFeed(feedId: _):
            return "PUT"
        case .deleteRSSFeed(feedId: _):
            return "DELETE"
        case .toggleReadArticle(feedId: _, articleId: _):
            return "PUT"
        }
    }
}
