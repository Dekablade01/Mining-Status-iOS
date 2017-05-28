//
//  AddServiceSingleton.swift
//  eMiner
//
//  Created by Issarapong Poesua on 5/28/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class AddServiceSingleton: NSObject
{
    static var sharedInstance = AddServiceSingleton()
    
    var serviceModel = ServiceModel()
    
    func clear()
    {
        serviceModel.address = ""
        serviceModel.currency = ""
        serviceModel.poolname = ""
    }

}
