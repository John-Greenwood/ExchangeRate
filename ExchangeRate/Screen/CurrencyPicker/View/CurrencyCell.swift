//
//  CurrencyCell.swift
//  ExchangeRate
//
//  Created by John Greenwood on 09.04.2021.
//

import UIKit

class CurrencyCell: UITableViewCell {
    
    override var isSelected: Bool {
        didSet {
            guard let imageView = imageView else { return }
            UIView.transition(with: imageView, duration: 0.2, options: .transitionCrossDissolve) { [weak self] in
                self?.imageView?.image = self?.isSelected ?? false ? .radioActive : .radioInactive
            }
        }
    }
    
}
