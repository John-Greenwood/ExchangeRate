//
//  DimensionsManager.swift
//  ExchangeRate
//
//  Created by John Greenwood on 09.04.2021.
//

import UIKit

class DimensionsManager {
    
    static let screenBounds = UIScreen.main.bounds
    static let idealBounds = CGRect(x: 0, y: 0, width: 375, height: 812)
    static let differenceBounds = CGRect(x: 0, y: 0,
                                         width: screenBounds.width / idealBounds.width,
                                         height: screenBounds.height / idealBounds.height)
    
    static let verticalMultiplier = differenceBounds.height
    static let horisontalMultiplier = differenceBounds.width
}
