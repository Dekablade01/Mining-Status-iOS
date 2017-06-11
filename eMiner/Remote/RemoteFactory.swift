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
    static let digitalOcean = "http://128.199.166.29:5000/api/"
}

enum API
{
    static let server = Server.heroku
    static let poolList = API.server + "pool-list/"
    static let dashboard = API.server
    static let nicehashDashBoard = "https://www.nicehash.com/index.jsp?utm_source=NHM&p=miners&addr="
    static let ownNiceHash = API.server + "ownNiceHash/"
    
    static var niceHashStatProvider: String { return "https://api.nicehash.com/api?method=stats.provider&addr=" }
    static var niceHashStatProviderWorkers:String { return "https://api.nicehash.com/api?method=stats.provider.workers&addr="}
    
    static var nanoPoolGeneral: String { return "https://api.nanopool.org/v1/"}
    
    static let walletValidator = API.server + "validateWallet/"
    static let poolURL = API.server + "pool-url/"
    static let currencies = API.server + "currencies/"
    static var currencyCalculator: String { return "https://min-api.cryptocompare.com/data/price?fsym=" }
    
        
        
}

class RemoteFactory: NSObject
{
    static var remoteFactory = RemoteFactory()
    var remoteMiningDashBoard: RemoteMiningDashBoard
    var remoteNiceHash: RemoteNiceHash
    var remoteWalletValidator : RemoteWalletValidator
    var remotePoolURL: RemotePoolURL
    var remoteCurrency: RemoteCurrency
    var remoteCurrencyCalculator: RemoteCurrencyCalculator
    var remoteFlyPool: RemoteFlyPool
    var remoteNanoPool: RemoteNanoPool
    override init() {
        remoteMiningDashBoard = RemoteMiningDashBoard()
        remoteNiceHash = RemoteNiceHash()
        remoteWalletValidator = RemoteWalletValidator()
        remotePoolURL = RemotePoolURL()
        remoteCurrency = RemoteCurrency()
        remoteCurrencyCalculator = RemoteCurrencyCalculator()
        remoteFlyPool = RemoteFlyPool()
        remoteNanoPool = RemoteNanoPool()
        
        super.init()
    }
}
