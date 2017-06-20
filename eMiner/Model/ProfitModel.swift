//
//  ProfitModel.swift
//  eMiner
//
//  Created by Issarapong Poesua on 6/20/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import ObjectMapper

class ProfitModel: Mappable
{
    var recommendedAlgorithmID: String = ""
    var profit: Double = 0.0
    var error: String? = nil
    
    
    func mapping(map: Map)
    {
        self.recommendedAlgorithmID <- map["current_algo"]
        self.profit <- map["current_prof"]
        self.error <- map["error"]
    }
    required init?(map: Map)
    {
        
    }
    init(id: String, profit: Double) {
        self.recommendedAlgorithmID = id
        self.profit = profit
    }
}
