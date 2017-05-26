//
//  CellContentModel.swift
//  Mining-Status
//
//  Created by Issarapong Poesua on 5/26/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class CellContentModel: NSObject
{
    var cellHeadingName: String
    var cellValue: String
    
    init(name: String, value: String)
    {
        self.cellHeadingName = name
        self.cellValue = value
        
        super.init()
    }
}
