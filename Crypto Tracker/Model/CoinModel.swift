
//
//  coinModel.swift
//  ByteCoin
//
//  Created by Ebubechukwu Dimobi on 11.07.2020.
//  Copyright © 2020 blazeapps. All rights reserved.
//

import Foundation

struct CoinModel {
    
    let rate: Double
    let currencyName: String
    
    var rateToString: String{
        return String(format: "%.2f", rate)
    }
}
