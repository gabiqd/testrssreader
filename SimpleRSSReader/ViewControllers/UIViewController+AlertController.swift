//
//  UIViewController+AlertController.swift
//  SimpleRSSReader
//
//  Created by Gabriel on 21/09/2020.
//  Copyright © 2020 Gabriel. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
}
