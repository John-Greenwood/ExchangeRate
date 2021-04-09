//
//  UIViewController+NavbarDimensions.swift
//  ExchangeRate
//
//  Created by John Greenwood on 09.04.2021.
//

import UIKit

extension UIViewController {
    
    var statusBarHeight: CGFloat {
        get {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            return window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        }
    }
    
    var navbarHeight: CGFloat {
        get {
            navigationController?.navigationBar.frame.size.height ?? 0
        }
    }
    
    
    var navbarMaxY: CGFloat {
        get {
            statusBarHeight + navbarHeight
        }
    }
}
