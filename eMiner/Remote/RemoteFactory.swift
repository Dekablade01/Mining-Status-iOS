//
//  Remote.swift
//  Mining-Status
//
//  Created by Issarapong Poesua on 5/25/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class RemoteFactory: NSObject
{
    static var remoteFactory = RemoteFactory()
    var remoteNiceHash = RemoteNiceHash()
    var remoteCurrency = RemoteCurrency()
    var remoteCurrencyCalculator = RemoteCurrencyCalculator()
    var remoteFlyPool = RemoteFlyPool()
    var remoteNanoPool = RemoteNanoPool()
    var remoteHardware = RemoteHardware()
    
    override init() {

        
        super.init()
    }
}
