//
//  UIViewController+HideKeyboard.swift
//  ExchangeRate
//
//  Created by John Greenwood on 09.04.2021.
//

import UIKit

extension UIViewController {
    
    func addKeyboardHideGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gesture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
