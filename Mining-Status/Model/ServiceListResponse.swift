//
//  ServiceList.swift
//  Mining-Status
//
//  Created by Issarapong Poesua on 5/26/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import ObjectMapper

class ServiceListResponse: Mappable
{
    var items:[String] = []
    
    
    init ()
    {
    }
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        self.items <- map["serviceList"]
    }
}
