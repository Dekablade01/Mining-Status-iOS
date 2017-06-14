//
//  RemoteCurrency.swift
//  eMiner
//
//  Created by Issarapong Poesua on 6/7/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RemoteCurrency: NSObject {
    
    var currenciesName:[String] = []
    var currenciesSymbol:[String] = []

    func loadCurrencies(callback: ( ([String],[String]) -> ())? )
    {
        Alamofire.request(APIs.ownSupportedCurrencies()).responseJSON(){
            if let result = $0.result.value
            {
                let json = JSON(result)
            
                let currencyNames = json["fullNames"].arrayValue.map(){ $0.stringValue }
                let currencySymbols = json["symbols"].arrayValue.map(){ $0.stringValue }
                self.currenciesName = currencyNames
                self.currenciesSymbol = currencySymbols
                callback?(currencySymbols, currencyNames)
                
                
            }
        }
    }
    
}


