//
//  RemoteNanoPool.swift
//  eMiner
//
//  Created by Issarapong Poesua on 6/11/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RemoteNanoPool: NSObject
{
    var error: String?
    
    
    func getNanoPool(address: String, coin: String, callback: (([CellContentModel], String?)->())?)
    {
        Alamofire.request(APIs.nanoPoolGeneral(coin: coin, address: address)).responseJSON()
            {
                if let value = $0.result.value
                {
                    let json = JSON(value)
                    
                    if (json["status"].boolValue == true) // api success
                    {
                        self.error = nil
                        
                        let data = json["data"]
                        let address = data["account"].stringValue
                        var hashRateString = ""
                        var avgHashRateString = ""

                        
                        if (coin == Currency.sia || coin == Currency.etc || coin == Currency.eth)
                        {
                            hashRateString = String((data["hashrate"].doubleValue / 1000).roundTo(places: 2)) + " GH/s"
                            avgHashRateString = String((data["avgHashrate"]["h1"].doubleValue / 1000).roundTo(places: 2)) + " GH/s"
                            
                            
                        }
                        else if (coin == Currency.zec)
                        {
                            hashRateString = String((data["hashrate"].doubleValue / 1000).roundTo(places: 2)) + " KS/s"
                            avgHashRateString = String((data["avgHashrate"]["h1"].doubleValue / 1000).roundTo(places: 2)) + " KS/s"
                        }
                        
                        var balance = data["balance"].doubleValue
                        print("balance : ", balance)
                        if (balance > 0)
                        {
                            if (coin == Currency.sia)
                            {
                                balance = data["balance"].doubleValue.roundTo(places: 1)
                            }
                            else
                            {
                                balance = data["balance"].doubleValue.roundTo(places: 6)
                                
                            }
                        }
                        
                        let workersDetail = data["workers"].arrayValue
                        
                        var workers:[WorkerModel] = []
                        
                        for workerDetail in workersDetail
                        {
                            let worker = WorkerModel(name: workerDetail["id"].stringValue,
                                                     hashRate: workerDetail["hashrate"].doubleValue,
                                                     avgHashRate: workerDetail["avg_h1"].doubleValue)
                            print("name : \(worker.workerName), hashrate : \(worker.hashRate), avgHashRate : \(worker.avgHashRate)")
                            workers.append(worker)
                        }
                        
                        let activeWorkers = workers.filter() { $0.hashRate != 0 }
                        
                        var contents: [CellContentModel] = []
                        contents.append(CellContentModel(name: "Address", value: address))
                        contents.append(CellContentModel(name: "Workers", value: activeWorkers.count))
                        contents.append(CellContentModel(name: "HashRate", value: hashRateString))
                        contents.append(CellContentModel(name: "AvgHashRate", value: avgHashRateString))
                        contents.append(CellContentModel(name: "Unpaid", value: balance))
                        
                        var coinForExchange = ""
                        if (coin == Currency.sia) { coinForExchange = "SC" }
                        else { coinForExchange = coin }
                        
                        RemoteFactory
                            .remoteFactory
                            .remoteCurrencyCalculator
                            .convert(balance,
                                     from: coinForExchange.uppercased()){
                                      
                                        self.error = $0.1
                                        contents.append(CellContentModel(name: "In \(RemoteCurrencyCalculator.toCurrency.uppercased())",
                                            value: $0.0.roundTo(places: 2)))
                                    
                                        callback?(contents, self.error)
                        }
                    }
                    else // api response error
                    {
                        let data = json["data"].string
                        let error = json["error"].string
                        
                        if (data != nil)
                        {
                            self.error = data
                        }
                        else
                        {
                            self.error = error
                        }
                        print(self.error!)
                        callback?([], self.error!)
                    }
                    
                }
                else
                {
                    print($0.result.value)
                    self.error = "Server is unavailable right now."
                    print(self.error!)
                    callback?([], self.error!)
                    
                }
        }
    }
}
