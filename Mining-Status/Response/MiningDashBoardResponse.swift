//
//  MiningDashBoardResponse.swift
//  Mining-Status
//
//  Created by Issarapong Poesua on 5/26/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import ObjectMapper

class MiningDashBoardResponse: Mappable {
    
    var address:String = ""
    var numberOfRunningWorkers: Int = 0
    var currentRashRate: String = ""
    var averageHashRate: String = ""
    var unpaidBalance: Double = 0
    var unpaidBalanceInBTC: Double = 0
    var unpaidBalanceInOther: Double = 0
    var numberOfBlock: Int = 0
    
    var expectCurrency: String = ""

    required init?(map: Map) {
        
    }
    init() {
        
    }
    func mapping(map: Map) {
        address <- map["address"]
        numberOfRunningWorkers <- map["numberOfRunningWorkers"]
        currentRashRate <- map["currentHashRate"]
        averageHashRate <- map["averageHashRate"]
        unpaidBalance <- map["unpaidBalance"]
        unpaidBalanceInBTC <- map["unpaidBalanceInBTC"]
        unpaidBalanceInOther <- map[expectCurrency]
        numberOfBlock <- map["block"]
    }
    
}
