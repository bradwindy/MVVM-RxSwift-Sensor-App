//
//  Currency.swift
//  TemplateProject
//
//  Created by Benoit PASQUIER on 13/01/2018.
//  Copyright © 2018 Benoit PASQUIER. All rights reserved.
//

import Foundation

enum Currency : String {
    case EUR
    case GBP
    case USD
}

enum CurrencyLocale : String {
    case EUR = "fr_FR"
    case GBP = "en_UK"
}

struct CurrencyRate: Equatable {
    
    let currencyIso : String
    let rate : Double
    
    public static func == (lhs: CurrencyRate, rhs: CurrencyRate) -> Bool {
        return lhs.rate == rhs.rate &&
            lhs.currencyIso == rhs.currencyIso
    }
}
