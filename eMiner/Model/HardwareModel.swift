//
//  HardwareModel.swift
//  eMiner
//
//  Created by Issarapong Poesua on 6/12/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import ObjectMapper

class HardwareModel: Mappable
{
    var id: Int = 0
    var name: String = ""
    var price: Int = 0
    var power: Int = 0
    var speeds: [Double] = []
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        price <- map["price"]
        power <- map["power"]
        speeds <- map["speeds"]
    }
    required init?(map: Map) {
        
    }

}
