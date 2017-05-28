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
    static let sharedInstance = AddServiceSingleton()
    
    var serviceModel = ServiceModel()
}
