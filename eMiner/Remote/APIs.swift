//
//  API.swift
//  eMiner
//
//  Created by Issarapong Poesua on 6/13/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class APIs: NSObject
{
    
    static var server: String { return getRawValue(server: .production) }
    
    static func getRawValue(server: Server) -> String
    {
        return server.rawValue
    }
    
    static func niceHashDashboard(address: String) -> String
    {
        return "https://www.nicehash.com/index.jsp?utm_source=NHM&p=miners&addr=" + address
    }
    static func niceHashStatProvider(address: String) -> String
    {
        return "https://api.nicehash.com/api?method=stats.provider&addr=" + address
    }
    static func niceHashStatProviderWorker(address: String, algo: String) -> String
    {
        return "https://api.nicehash.com/api?method=stats.provider.workers&addr=" + address + "&algo=" + algo
    }
    static func ownNiceHashHardwareList() -> String
    {
        return  server + "hardware-list/"
    }
    static func nanoPoolGeneral(coin: String, address: String) -> String
    {
        return "https://api.nanopool.org/v1/" + coin.lowercased() + "/user/" + address
    }
    static func flyPoolAPI(address: String) -> String
    {
        return "https://zcash.flypool.org/api/miner_new/" + address
    }
    static func flyPoolDashboard(address: String) -> String
    {
        return "https://zcash.flypool.org/miners/" + address
    }
    static func ethermineAPI(coin: String, address: String) -> String
    {
        if coin == Currency.eth
        {
            return "https://ethermine.org/api/miner_new/" + address
        }
        if coin == Currency.etc
        {
            return "https://etc.ethermine.org/api/miner_new/" + address
        }
        return ""
    }
    static func ethermineDashBoard(coin: String, address: String) -> String
    {
        if coin == Currency.eth
        {
            return "https://ethermine.org/miners/" + address
        }
        if coin == Currency.etc
        {
            return "https://etc.ethermine.org/miners/" + address
        }
        return ""
    }
    static func ownFlyPoolWorkers(coin: String, address: String) -> String
    {
        return server + "flypool/workers/\(coin)/\(address)"
    }
    static func currencyCalculator(from: String, to: String) -> String
    {
        return "https://min-api.cryptocompare.com/data/price?fsym=" + from.uppercased() + "&tsyms=" + to.uppercased()
    }
    static func ownSupportedCurrencies() -> String
    {
        return server + "currencies/"
    }
    static func calculateProfit()-> String
    {
        return "https://api.nicehash.com/calc"
    }
    
    
    
}

enum Server: String
{
    case localhost = "http://192.168.10.101:5000/api/"
    case production = "https://eminer-server.herokuapp.com/api/"
    case beta = "https://eminers-server-beta.herokuapp.com/api/"
}
