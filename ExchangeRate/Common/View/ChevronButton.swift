//
//  ChevronButton.swift
//  ExchangeRate
//
//  Created by John Greenwood on 09.04.2021.
//

import UIKit

class ChevronButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setImage(.chevronDown, for: .normal)
        semanticContentAttribute = .forceRightToLeft
        
        titleEdgeInsets = UIEdgeInsets(top: 0,
                                       left: -6,
                                       bottom: 0,
                                       right: 6)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
