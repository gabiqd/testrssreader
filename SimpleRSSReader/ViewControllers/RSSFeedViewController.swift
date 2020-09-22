//
//  RSSFeedViewController.swift
//  SimpleRSSReader
//
//  Created by Gabriel on 21/09/2020.
//  Copyright © 2020 Gabriel. All rights reserved.
//

import UIKit

class RSSFeedViewController: UITableViewController {
    private var emptyFeedDisclaimerView: UILabel!
    private var userViewModel: UserViewModel!
    private var feedViewModel: RSSFeedViewModel!
    private let rssFeedCellID = "rssFeedCellID"
    
    private var hasBeenUpdated: Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        setUpNavigation()
    }
    
    func setUpNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "RSS Feed List"
        
        let addButton = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(addRSSFeed))
        
        let logOutButton = UIBarButtonItem(title: "Log Out", style: .done, target: self, action: #selector(logOut))
        
        navigationItem.rightBarButtonItem = addButton
        navigationItem.leftBarButtonItem = logOutButton
    }
    
    func getFeeds() {
        feedViewModel.getFeeds() { [weak self] (error) in
            if let error = error {
                self?.showAlert(title: "Ups", message: error.message)
            }
            
            self?.tableView.reloadData()
        }
    }
    
    @objc func logOut(){
        userViewModel.logOutCurrentUset()
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func addRSSFeed(){
        navigationController?.pushViewController(AddFeedViewController(delegate: self, feedViewModel: feedViewModel), animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .backgroundColor
        self.navigationItem.hidesBackButton = true;
        

        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        tableView.register(RSSFeedTableViewCell.self, forCellReuseIdentifier: rssFeedCellID)
        
        initViews()
        setUpConstraints()
        
        getFeeds()
        
        feedViewModel.isHiddenDisclaimer.bind { [weak self] (isHidden) in
            self?.emptyFeedDisclaimerView.isHidden = isHidden
        }
        
        feedViewModel.hasBeenUpdated.bind { [weak self] (hasBeenUpdated) in
            if hasBeenUpdated { DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    init(userViewModel: UserViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.userViewModel = userViewModel
        
        self.feedViewModel = RSSFeedViewModel(with: userViewModel.accessToken)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initViews() {
        emptyFeedDisclaimerView = {
            let disclaimer = UILabel()
            disclaimer.translatesAutoresizingMaskIntoConstraints = false
            disclaimer.font = UIFont.titleCellFont
            disclaimer.textColor = .textColor
            disclaimer.text = "Please add some RSS feed"
            disclaimer.isHidden = true
            
            return disclaimer
        }()
    }
    
    func setUpConstraints() {
        self.view.addSubview(emptyFeedDisclaimerView)
        
        NSLayoutConstraint.activate(
            [
                emptyFeedDisclaimerView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
                emptyFeedDisclaimerView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            ]
        )
    }
}

extension RSSFeedViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedViewModel.feedsCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: rssFeedCellID, for: indexPath) as? RSSFeedTableViewCell else {
            fatalError("Unexpected Index Path")
        }
        cell.setTitle(feedViewModel.getFeedTitle(with: indexPath))
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let articleViewModel = RSSArticleViewModel(with: userViewModel.accessToken, feedId: feedViewModel.getFeedID(of: indexPath))
        navigationController?.pushViewController(RSSArticlesViewController(articlesViewModel: articleViewModel), animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            feedViewModel.removeRSSFeed(with: indexPath) { [weak self] (errorMessage) in
                if let message = errorMessage { self?.showAlert(title: "Ups!", message: message); return }
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
}

extension RSSFeedViewController: AddFeedDelegate {
    func newFeedAdded(with urlString: String) {
        print("New Feed")
        self.feedViewModel.addRSSFeed(withURL: urlString) { [weak self] (errorMessage) in
            guard let self = self else { return }
            if let message = errorMessage { self.showAlert(title: "Ups", message: message); return }
            
        }
        
    }
}
