//
//  PoolModel.swift
//  eMiner
//
//  Created by Issarapong Poesua on 5/27/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import ObjectMapper
class PoolModel: Mappable
{
    var name = ""
    var currencies: [String] = []
    
    func mapping(map: Map) {
        name <- map["name"]
        currencies <- map ["currencies"]
    }
    required init?(map: Map) {
        
    }
    init(name: String, currencies: [String])
    {
        self.name = name
        self.currencies = currencies
    }
    
}
