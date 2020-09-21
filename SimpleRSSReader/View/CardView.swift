//
//  CardView.swift
//  SimpleRSSReader
//
//  Created by Gabriel on 21/09/2020.
//  Copyright © 2020 Gabriel. All rights reserved.
//

import UIKit

class CardView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 14
        self.layer.masksToBounds = true
        self.backgroundColor = .cardBackgroundColorScheme
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
