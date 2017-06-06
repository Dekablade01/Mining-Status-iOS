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
    static let localhost = "http://192.168.10.101:5000/api/"
    static let heroku = "https://eminer-server.herokuapp.com/api/"
}

enum API
{
    static let server = Server.localhost
    static let poolList = API.server + "pool-list"
    static let dashboard = API.server
    static let nicehashDashBoard = "https://www.nicehash.com/index.jsp?utm_source=NHM&p=miners&addr="
    static let ownNiceHash = API.server + "ownNiceHash/"
    static let walletValidator = API.server + "validateWallet/"
    
}

class RemoteFactory: NSObject
{
    static var remoteFactory = RemoteFactory()
    var remoteService: RemoteService
    var remoteMiningDashBoard: RemoteMiningDashBoard
    var remoteNiceHash: RemoteNiceHash
    var remoteWalletValidator : RemoteWalletValidator
    
    override init() {
        remoteService = RemoteService()
        remoteMiningDashBoard = RemoteMiningDashBoard()
        remoteNiceHash = RemoteNiceHash()
        remoteWalletValidator = RemoteWalletValidator()
        
        super.init()
    }
}
