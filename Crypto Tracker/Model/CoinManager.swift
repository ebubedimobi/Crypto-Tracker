//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Ebubechukwu Dimobi on 11.07.2020.
//  Copyright © 2020 blazeapps. All rights reserved.
//


import Foundation

protocol CoinManagerDelegate {
    func didUpdateCurrency( with coinModel: CoinModel)
    func didFailWithError(with error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
   // let apiKey: String     //input apikey here
    
    var delegate: CoinManagerDelegate?
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinName(for currency: String){
        let urlString = "\(baseURL)/\(currency)\("apiKey")"
        performRequest(with: urlString)
    }
    
    
    
    func performRequest(with urlString: String){
        
        if let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error != nil{
                    self.delegate?.didFailWithError(with: error!)
                    return
                }
                
                if let safeData = data{
                    
                    if let coinModel = self.parseJSON(coinData: safeData){
                        
                        self.delegate?.didUpdateCurrency(with: coinModel)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(coinData: Data) -> CoinModel?{
        
        let decoder = JSONDecoder()
        
        do{
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            let decodedRate = decodedData.rate
            let decodedCurrencyName = decodedData.asset_id_quote
           
            
            let coinModel = CoinModel(rate: decodedRate, currencyName: decodedCurrencyName)

            return coinModel
            
        }catch {
            self.delegate?.didFailWithError(with: error)
            
            return nil
        }
        
    }
}
