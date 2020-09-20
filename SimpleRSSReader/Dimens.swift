//
//  Dimens.swift
//  SimpleRSSReader
//
//  Created by Gabriel on 20/09/2020.
//  Copyright © 2020 Gabriel. All rights reserved.
//

import UIKit

enum Dimens {
    case s
    case m
    case l
    
    var value: CGFloat {
        switch self {
        case .s:
            return 16.0
        case .m:
            return 32.0
        case .l:
            return 64.0
        }
    }
}
