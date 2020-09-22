//
//  BaseNavigationController.swift
//  SimpleRSSReader
//
//  Created by Gabriel on 20/09/2020.
//  Copyright © 2020 Gabriel. All rights reserved.
//

import Foundation
import UIKit

class BaseNavigationController: UINavigationController {
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationBar.tintColor = UIColor.primaryColor
        self.navigationBar.isTranslucent = false
        self.navigationBar.prefersLargeTitles = true
        
        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .backgroundColor
    }
}
