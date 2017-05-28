//
//  ServiceModel.swift
//  eMiner
//
//  Created by Issarapong Poesua on 5/28/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper
import Realm

class ServiceModel: Object, Mappable
{
    dynamic var address = ""
    dynamic var poolname = ""
    dynamic var currency = ""
    
 
    required convenience init?(map: Map) {
        self.init()
    }
    func mapping(map: Map)
    {
        self.address <- map["address"]
        self.poolname <- map["poolname"]
        self.currency <- map["currency"]
    }
    
}
