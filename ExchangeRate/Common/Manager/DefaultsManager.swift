//
//  DefaultsManager.swift
//  ExchangeRate
//
//  Created by John Greenwood on 09.04.2021.
//

import Foundation

class DefaultsManager {
    
    static var cacheRatesResponse: String? {
        
        get {
            UserDefaults.standard.string(forKey: "ratesCache")
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: "ratesCache")
        }
    }
}
