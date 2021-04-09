//
//  BottomBorderedTextField.swift
//  ExchangeRate
//
//  Created by John Greenwood on 09.04.2021.
//

import UIKit

class BottomBorderedTextField: UIView {
    
    var textField = UITextField()
    var titleLabel = UILabel()
    var bottomBorder = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Setup views
        let stack = UIStackView(frame: CGRect(x: 0, y: 0, width: frame.width, height: 69))
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = 8
        stack.autoresizingMask = [.flexibleWidth]
        addSubview(stack)
        
        titleLabel.textColor = .secondaryLabelColor
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        stack.addArrangedSubview(titleLabel)
        
        textField.font = UIFont.boldSystemFont(ofSize: 28)
        textField.textColor = .textFieldTextColor
        textField.keyboardType = .phonePad
        stack.addArrangedSubview(textField)
        
        bottomBorder.backgroundColor = .secondaryLabelColor
        bottomBorder.frame.size.width = frame.width
        bottomBorder.frame.size.height = 0.6
        bottomBorder.setContentHuggingPriority(.defaultLow, for: .vertical)
        stack.addArrangedSubview(bottomBorder)
        
        self.frame.size.height = stack.frame.size.height
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
