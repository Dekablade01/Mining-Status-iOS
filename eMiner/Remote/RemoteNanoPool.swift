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
        Alamofire.request(API.nanoPoolGeneral + coin.lowercased() + "/user/" + address).responseJSON()
            {
                if let value = $0.result.value
                {
                    let json = JSON(value)
                    
                    if (json["status"].boolValue == true) // api success
                    {
                        self.error = nil
                        
                        let data = json["data"]
                        let address = data["account"].stringValue
                        let hashRate = data["hashrate"].stringValue + " MH/s"
                        let avgHashRate = data["avgHashrate"]["h1"].stringValue + " MH/s"
                        let balance = data["balance"].doubleValue.roundTo(places: 7)
                        
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
                        contents.append(CellContentModel(name: "HashRate", value: hashRate))
                        contents.append(CellContentModel(name: "AvgHashRate", value: avgHashRate))
                        contents.append(CellContentModel(name: "Unpaid", value: balance))
                        
                        
                        RemoteFactory
                            .remoteFactory
                            .remoteCurrencyCalculator
                            .convert(balance,
                                     from: coin.uppercased()){
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
                    self.error = "Server is unavailable right now."
                    print(self.error!)
                    callback?([], self.error!)
                    
                }
        }
    }
}
