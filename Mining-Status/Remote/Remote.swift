//
//  Remote.swift
//  Mining-Status
//
//  Created by Issarapong Poesua on 5/25/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit


enum server
{
    static let localhost = "http://localhost:5000/api/"
    static let heroku = "https://salty-fortress-22218.herokuapp.com/api/"
}

enum API
{
    static let poolList = server.heroku + "pool-list"
    static let dashboard = server.heroku + "flypool/t1ax38iJtcS6cp6Tcx3N4B8akQ9NTEkhDdS/usd"
}

class RemoteFactory: NSObject
{
    static var remoteFactory = RemoteFactory()
    var remoteService: RemoteService
    var remoteMiningDashBoard: RemoteMiningDashBoard
    
    override init() {
        remoteService = RemoteService()
        remoteMiningDashBoard = RemoteMiningDashBoard()
        
        super.init()
    }
}
