//
//  RSSArticlesTableViewCell.swift
//  SimpleRSSReader
//
//  Created by Gabriel on 22/09/2020.
//  Copyright © 2020 Gabriel. All rights reserved.
//

import UIKit

class RSSArticlesTableViewCell: UITableViewCell {
    private var titleLabel: UILabel!
    private var urlLabel: UILabel!
    private var cardView: UIView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .backgroundColor
        
        initViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func setUrl(_ url: String) {
        urlLabel.text = url
    }
    
    func initViews(){
        titleLabel = {
            let titleLabel = UILabel()
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.font = UIFont.titleCellFont
            titleLabel.textColor = .textColor
            
            return titleLabel
        }()
        
        urlLabel = {
            let urlLabel = UILabel()
            urlLabel.translatesAutoresizingMaskIntoConstraints = false
            urlLabel.font = UIFont.urlFont
            urlLabel.textColor = .textColor
            
            return urlLabel
        }()
        
        cardView = {
            let cardView = CardView()
            cardView.translatesAutoresizingMaskIntoConstraints = false
            
            return cardView
        }()
    }
    
    func setUpConstraints(){
        self.addSubview(cardView)
        cardView.addSubview(titleLabel)
        cardView.addSubview(urlLabel)
        
        NSLayoutConstraint.activate(
            [
                cardView.topAnchor.constraint(equalTo: self.topAnchor, constant: Dimens.xs.value),
                cardView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Dimens.xs.value),
                cardView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Dimens.s.value),
                cardView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -Dimens.s.value)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                titleLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: Dimens.s.value),
                titleLabel.bottomAnchor.constraint(equalTo: urlLabel.topAnchor, constant: -Dimens.xs.value),
                titleLabel.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: Dimens.s.value),
                titleLabel.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -Dimens.s.value)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                urlLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Dimens.xs.value),
                urlLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -Dimens.s.value),
                urlLabel.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: Dimens.s.value),
                urlLabel.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -Dimens.s.value)
            ]
        )
        
    }
}
