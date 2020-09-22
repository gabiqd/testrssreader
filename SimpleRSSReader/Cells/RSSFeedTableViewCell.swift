//
//  RSSFeedTableViewCell.swift
//  SimpleRSSReader
//
//  Created by Gabriel on 22/09/2020.
//  Copyright © 2020 Gabriel. All rights reserved.
//

import UIKit

class RSSFeedTableViewCell: UITableViewCell {
    private var titleLabel: UILabel!
    private var cardView: UIView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .backgroundColor
        self.selectionStyle = .none
        
        initViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func initViews(){
        titleLabel = {
            let titleLabel = UILabel()
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.font = UIFont.titleCellFont
            titleLabel.textColor = .textColor
            
            return titleLabel
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
                titleLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -Dimens.s.value),
                titleLabel.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: Dimens.s.value),
                titleLabel.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -Dimens.s.value)
            ]
        )
        
    }
}
