//
//  CellContentModel.swift
//  Mining-Status
//
//  Created by Issarapong Poesua on 5/26/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import ObjectMapper

class CellContentModel: Mappable
{
    var name: String = ""
    var value: String = ""
    
    func mapping(map: Map) {
        name <- map["name"]
        value <- map["value"]
    }
    required init?(map: Map) {
        
    }
    init(name: String, value: String) {
        self.name = name
        self.value = value
    }

}
