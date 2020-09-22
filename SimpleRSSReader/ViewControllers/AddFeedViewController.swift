//
//  AddFeedViewController.swift
//  SimpleRSSReader
//
//  Created by Gabriel on 21/09/2020.
//  Copyright © 2020 Gabriel. All rights reserved.
//

import Foundation
import UIKit

class AddFeedViewController: UIViewController {
    private var descriptionLabel: UILabel!
    private var feedURLTextField: UITextField!
    private var addButton: StyledButton!
    private var cancelButton: AlternativeStyledButton!
    private var delegate: AddFeedDelegate!
    private var feedViewModel: RSSFeedViewModel!
    
    init(delegate: AddFeedDelegate, feedViewModel: RSSFeedViewModel){
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
        self.feedViewModel = feedViewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "Add RSS Feed"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .backgroundColor
        initViews()
        setUpConstraints()
    }
    
    func initViews() {
        descriptionLabel = {
            let descriptionLabel = UILabel()
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            descriptionLabel.text = "Please, enter the url of the feed you want to add"
            descriptionLabel.font = UIFont.descriptionFont
            descriptionLabel.lineBreakMode = .byWordWrapping
            descriptionLabel.numberOfLines = 0
            descriptionLabel.sizeToFit()
            descriptionLabel.textColor = UIColor.textColor
            
            return descriptionLabel
        }()
        
        feedURLTextField = {
            let feedURLTextField = UITextField()
            feedURLTextField.translatesAutoresizingMaskIntoConstraints = false
            feedURLTextField.placeholder = "Feed URL"
            
            return feedURLTextField
        }()
        
        addButton = {
            let addButton = StyledButton()
            addButton.translatesAutoresizingMaskIntoConstraints = false
            addButton.setTitle("Add", for: .normal)
            addButton.addTarget(self, action: #selector(addNewFeed), for: .touchUpInside)
            
            return addButton
        }()
        
        cancelButton = {
            let cancelButton = AlternativeStyledButton()
            cancelButton.translatesAutoresizingMaskIntoConstraints = false
            cancelButton.setTitle("Cancel", for: .normal)
            cancelButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
            
            return cancelButton
        }()
    }
    
    func setUpConstraints() {
        self.view.addSubview(descriptionLabel)
        self.view.addSubview(feedURLTextField)
        self.view.addSubview(addButton)
        self.view.addSubview(cancelButton)
        
        NSLayoutConstraint.activate(
            [
                descriptionLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: Dimens.m.value),
                descriptionLabel.bottomAnchor.constraint(equalTo: feedURLTextField.topAnchor, constant: -Dimens.m.value),
                descriptionLabel.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: Dimens.m.value),
                descriptionLabel.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -Dimens.m.value)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                feedURLTextField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Dimens.m.value),
                feedURLTextField.bottomAnchor.constraint(equalTo: addButton.topAnchor, constant: -Dimens.l.value),
                feedURLTextField.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: Dimens.m.value),
                feedURLTextField.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -Dimens.m.value)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                addButton.topAnchor.constraint(equalTo: feedURLTextField.bottomAnchor, constant: Dimens.l.value),
                addButton.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -Dimens.s.value),
                addButton.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: Dimens.l.value),
                addButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -Dimens.l.value)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                cancelButton.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: Dimens.s.value),
                cancelButton.bottomAnchor.constraint(lessThanOrEqualTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -Dimens.m.value),
                cancelButton.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: Dimens.l.value),
                cancelButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -Dimens.l.value)
            ]
        )
    }
    
    @objc func addNewFeed() {
        guard let urlText = feedURLTextField.text else {
            return
        }
        
        if urlText.isEmpty {
            showAlert(title: "Empty URL", message: "Please write a valid URL")
            return
        }
        
        delegate.newFeedAdded(with: urlText)
        dismissViewController()
    }
    
    @objc func dismissViewController() {
        navigationController?.popViewController(animated: true)
    }
}
