//
//  MainViewModel.swift
//  ExchangeRate
//
//  Created by John Greenwood on 09.04.2021.
//

import Foundation

class MainViewModel {
    
    var currencyRates: Box<[RatesResponse.Rate]?> = Box(nil)
    
    init() {
        loadCurrencyRates()
    }
    
    func loadCurrencyRates() {
        APIManager.loadRates { [weak self] (result, rates) in
            guard result else {
                self?.currencyRates.value = []
                return
            }
            
            self?.currencyRates.value = rates
        }
    }
}
