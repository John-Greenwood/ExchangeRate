//
//  MainNavigationController.swift
//  ExchangeRate
//
//  Created by John Greenwood on 09.04.2021.
//

import UIKit

class MainNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Colors
        navigationBar.barTintColor = .accentColor
        navigationBar.barStyle = .black
        
        // Shadow
        navigationBar.layer.masksToBounds = false
        navigationBar.layer.shadowColor = UIColor.shadowColor.cgColor
        navigationBar.layer.shadowOpacity = 1
        navigationBar.layer.shadowOffset = CGSize(width: 0, height: 4)
        navigationBar.layer.shadowRadius = 11
    }
}
