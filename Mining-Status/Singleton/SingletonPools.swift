//
//  SingleonPools.swift
//  eMiner
//
//  Created by Issarapong Poesua on 5/27/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class SingleonPools: NSObject
{
    static var singletonPools = SingleonPools()
    
    var pools: [PoolModel] = []
    
}
