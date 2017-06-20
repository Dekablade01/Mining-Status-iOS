//
//  CurrenciesDataResponse.swift
//  eMiner
//
//  Created by Issarapong Poesua on 6/17/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import ObjectMapper

class CurrenciesDataResponse: Mappable
{
    
    var currencies: [CurrencyModel] = []
    var status: Bool = false
    
    func mapping(map: Map)
    {
        
    }
    required init?(map: Map)
    {
        self.currencies <- map["currencies"]
        self.status <- map["status"]
        
    }
}
