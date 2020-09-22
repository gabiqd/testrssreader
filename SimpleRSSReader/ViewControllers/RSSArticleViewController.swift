//
//  RSSArticlesViewController.swift
//  SimpleRSSReader
//
//  Created by Gabriel on 21/09/2020.
//  Copyright © 2020 Gabriel. All rights reserved.
//

import Foundation
import UIKit

class RSSArticlesViewController: UITableViewController {
    private var emptyArticlesDisclaimerView: UILabel!
    private let rssArticlesCellID = "rssArticlesCellID"
    private var articlesViewModel: RSSArticleViewModel
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "RSS Articles Feed List"
        
        articlesViewModel.getArticles { [weak self] (error) in
            if let error = error {
                self?.showAlert(title: "Ups", message: error.message)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .backgroundColor

        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.register(RSSArticlesTableViewCell.self, forCellReuseIdentifier: rssArticlesCellID)
        
        initViews()
        setUpConstraints()
        
        articlesViewModel.isHiddenDisclaimer.bind { [weak self] (isHidden) in
            self?.emptyArticlesDisclaimerView.isHidden = isHidden
        }
    }
    
    init(articlesViewModel: RSSArticleViewModel) {
        self.articlesViewModel = articlesViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initViews() {
        emptyArticlesDisclaimerView = {
            let disclaimer = UILabel()
            disclaimer.translatesAutoresizingMaskIntoConstraints = false
            disclaimer.font = UIFont.titleCellFont
            disclaimer.textColor = .textColor
            disclaimer.text = "There's no articles"
            disclaimer.isHidden = true
            
            return disclaimer
        }()
    }
    
    func setUpConstraints() {
        self.view.addSubview(emptyArticlesDisclaimerView)
        
        NSLayoutConstraint.activate(
            [
                emptyArticlesDisclaimerView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
                emptyArticlesDisclaimerView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            ]
        )
    }
}

extension RSSArticlesViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlesViewModel.articlesCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: rssArticlesCellID, for: indexPath) as? RSSArticlesTableViewCell else {
            fatalError("Unexpected Index Path")
        }
        cell.setTitle(articlesViewModel.getTitle(with: indexPath))
        cell.setUrl(articlesViewModel.getURL(with: indexPath))
        
        return cell
    }
}
