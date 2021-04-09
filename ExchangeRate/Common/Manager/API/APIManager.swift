//
//  APIManager.swift
//  ExchangeRate
//
//  Created by John Greenwood on 09.04.2021.
//

import Foundation
import Alamofire

class APIManager {
    
    static private let baseDomain = "https://api.exchangerate-api.com"
    
    static func loadRates(completion: @escaping (Bool, [RatesResponse.Rate]) -> ()) {
        AF.request("\(baseDomain)/v6/latest").response { dataResponse in
            var responseString: String?
            
            switch dataResponse.result {
            case .success(_):
                if let data = dataResponse.data {
                    responseString = String(data: data, encoding: .utf8)
                }
            case .failure(_):
                responseString = DefaultsManager.cacheRatesResponse
            }
            
            guard let data = responseString?.data(using: .utf8),
                  let responseModel = try? JSONDecoder().decode(RatesResponse.self, from: data) else {
                completion(false, [])
                return
            }
            
            completion(true, responseModel.ratesModels)
        }
    }
}
