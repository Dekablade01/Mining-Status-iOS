//
//  WorkerModel.swift
//  eMiner
//
//  Created by Issarapong Poesua on 6/12/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import ObjectMapper

class WorkerModel: NSObject
{
    
    var workerName : String
    var hashRate : Double
    var avgHashRate: Double
    var balance: Double
    var algorithm: String
    
    init(name: String, algorithm: String = "",hashRate: Double = 0, avgHashRate: Double = 0, balance: Double = 0) {
        self.workerName = name
        self.algorithm = algorithm
        self.hashRate = hashRate
        self.avgHashRate = avgHashRate
        self.balance = balance
    }

    
    
    
}
