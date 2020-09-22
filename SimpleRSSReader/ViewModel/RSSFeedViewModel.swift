//
//  RSSFeedViewModel.swift
//  SimpleRSSReader
//
//  Created by Gabriel on 21/09/2020.
//  Copyright © 2020 Gabriel. All rights reserved.
//

import Foundation

class RSSFeedViewModel {
    typealias ErrorMessageCompletition = (String?)->()
    private let networkManager = NetworkManager()
    private var feeds = [RSSFeed]()
    private var accessToken = ""
    
    let isHiddenDisclaimer = BindingBox(false)
    let hasBeenUpdated = BindingBox(false)
    
    init(with accessToken: String) {
        self.accessToken = accessToken
    }
    
    var feedsCount: Int {
        return feeds.count
    }
    
    func getFeedTitle(with indexPath: IndexPath) -> String {
        return feeds[indexPath.row].title
    }
    
    func getFeedID(of indexPath: IndexPath) -> Int {
        return feeds[indexPath.row].id
    }
    
    func addRSSFeed(withURL urlString: String, completition: ErrorMessageCompletition) {
        guard let _ = URL(string: urlString) else { completition("Wrong url format"); return }
        let id = Int.random(in: 1..<25)
        let rssFeed = RSSFeed(id: id, title: "Test \(id)", url: urlString)
        
        feeds.append(rssFeed)
        
        isHiddenDisclaimer.value = !feeds.isEmpty
        hasBeenUpdated.value = true
        
        completition(nil)
    }
    
    func removeRSSFeed(with indexPath: IndexPath, completition: ErrorMessageCompletition) {
        feeds.remove(at: indexPath.row)
        hasBeenUpdated.value = true

        completition(nil)
    }
    
    func getFeeds(completition: @escaping (_ error: NetworkError?)->()) {
//        let newFeeds = [RSSFeed(id: 1, title: "Title 1", url: "url 1"), RSSFeed(id: 2, title: "Title 2", url: "url 2"), RSSFeed(id: 3, title: "asdasdasd asdasd asdasd asd asd asd asd", url: "url 3")]
        
        let newFeeds = [RSSFeed]()
        
        if feeds != newFeeds {
            self.feeds = newFeeds
            isHiddenDisclaimer.value = !feeds.isEmpty
            hasBeenUpdated.value = true
        } else {
            hasBeenUpdated.value = false
        }
        
    }
}
