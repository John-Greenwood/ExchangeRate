//
//  RatesResponse.swift
//  ExchangeRate
//
//  Created by John Greenwood on 09.04.2021.
//

import Foundation

struct RatesResponse: Codable {
    
    let result: String
    let rates: [String: Double]
    
    struct Rate {
        let currency: String
        let rate: Double
    }
    
    var ratesModels: [Rate] {
        get {
            var result: [Rate] = []
            for (currency, rate) in rates {
                result.append(Rate(currency: currency, rate: rate))
            }
            return result.sorted { (r1, r2) -> Bool in
                r1.currency < r2.currency
            }
        }
    }
}
