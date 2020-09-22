//
//  AlternativeStyledButton.swift
//  SimpleRSSReader
//
//  Created by Gabriel on 22/09/2020.
//  Copyright © 2020 Gabriel. All rights reserved.
//

import UIKit

class AlternativeStyledButton: UIButton {
    private let nonClickColor = UIColor.primaryColor
    private let clickColor = UIColor.secondaryColor
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .backgroundColor
        self.layer.borderColor = nonClickColor.cgColor
        self.layer.borderWidth = 1
        self.contentEdgeInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15);
        self.titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        self.setTitleColor(nonClickColor, for: .normal)
        self.setTitleColor(clickColor, for: .highlighted)
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        didSet {
            layer.borderColor = isHighlighted ? clickColor.cgColor : nonClickColor.cgColor
        }
    }
}
