//
//  Remote.swift
//  Mining-Status
//
//  Created by Issarapong Poesua on 5/25/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit


enum Server
{
    static let localhost = "http://localhost:5000/api/"
    static let heroku = "https://salty-fortress-22218.herokuapp.com/api/"
}



enum API
{
    static let server = Server.localhost
    static let poolList = API.server + "pool-list"
    static let dashboard = API.server + "flypool/t1ax38iJtcS6cp6Tcx3N4B8akQ9NTEkhDdS/thb"
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
