//
//  RSSArticleViewModel.swift
//  SimpleRSSReader
//
//  Created by Gabriel on 21/09/2020.
//  Copyright © 2020 Gabriel. All rights reserved.
//

import Foundation

class RSSArticleViewModel {
    private let networkManager = NetworkManager()
    private var articles = [RSSArticle]()
    private var accessToken: String
    private var feedId: Int
    
    let isHiddenDisclaimer = BindingBox(false)
    
    init(with accessToken: String, feedId: Int) {
        self.accessToken = accessToken
        self.feedId = feedId
    }
    
    var articlesCount: Int {
        return articles.count
    }
    
    func getTitle(with indexPath: IndexPath) -> String {
        return articles[indexPath.row].title
    }
    
    func getURL(with indexPath: IndexPath) -> String {
        return articles[indexPath.row].url
    }
    
    func getArticles(completition: @escaping (_ error: NetworkError?)->()) {
        let newArt = [RSSArticle(id: 1, title: "Title Art1", url: "asdads", summary: "", content: "", date: "", readBy: [1], loaded: ""), RSSArticle(id: 2, title: "Title Art2", url: "sdsadasdads", summary: "", content: "", date: "", readBy: [2], loaded: "")]
        
        self.articles = newArt
        
        isHiddenDisclaimer.value = !articles.isEmpty
    }
}
