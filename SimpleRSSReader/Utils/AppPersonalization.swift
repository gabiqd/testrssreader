//
//  AppPersonalization.swift
//  SimpleRSSReader
//
//  Created by Gabriel on 20/09/2020.
//  Copyright © 2020 Gabriel. All rights reserved.
//

import UIKit

extension UIColor {
    static let primaryColor = UIColor(named: "primaryColorScheme") ?? blue
    static let secondaryColor = UIColor(named: "secondaryColorScheme") ?? brown
    static let textColor = UIColor(named: "textColorScheme") ?? black
    static let backgroundColor = UIColor(named: "backgroundColorScheme") ?? white
    static let cardBackgroundColorScheme = UIColor(named: "cardBackgroundColorScheme") ?? white
}

extension UIFont {
    static let titleFont = UIFont.systemFont(ofSize: 32.0, weight: .bold)
    static let descriptionFont = UIFont.systemFont(ofSize: 16.0, weight: .medium)
    static let urlFont = UIFont.systemFont(ofSize: 14.0, weight: .light)
    
    static let titleCellFont = UIFont.systemFont(ofSize: 16.0, weight: .bold)
}
