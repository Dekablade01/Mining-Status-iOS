//
//  CurrencyModel.swift
//  eMiner
//
//  Created by Issarapong Poesua on 6/17/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import ObjectMapper

class CurrencyModel: Mappable
{
    var symbol:String = ""
    var name: String = ""
    
    
     func mapping(map: Map) {
        self.symbol <- map["symbol"]
        self.name <- map["name"]
        
    }
    required init?(map: Map) {
        
    }
    init (name: String, symbol: String)
    {
        self.name = name
        self.symbol = symbol
    }
}
