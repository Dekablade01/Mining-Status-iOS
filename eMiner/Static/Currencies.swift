//
//  Currencies.swift
//  eMiner
//
//  Created by Issarapong Poesua on 6/25/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class Currencies: NSObject
{

    

    func getCurrencies() -> [CurrencyModel]
    {
        var currencies:[CurrencyModel] = []
        currencies.append(CurrencyModel(name: "AED", symbol: "United Arab Emirates Dirham"))
        currencies.append(CurrencyModel(name: "AFD", symbol: "Afghan Afghani"))
        currencies.append(CurrencyModel(name: "ALL", symbol: "Albanian Lek"))
        currencies.append(CurrencyModel(name: "AOA", symbol: "Angolan Kwanza"))
        currencies.append(CurrencyModel(name: "ARS", symbol: "Argentine Peso"))
        currencies.append(CurrencyModel(name: "AUD", symbol: "Australien Dollar"))
        currencies.append(CurrencyModel(name: "AZN", symbol: "Azerbaijani Manat"))
        return currencies
    }
    
    
    
}
