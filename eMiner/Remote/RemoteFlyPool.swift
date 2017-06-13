//
//  RemoteFlyPool.swift
//  eMiner
//
//  Created by Issarapong Poesua on 6/11/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import JavaScriptCore

class RemoteFlyPool: NSObject
{
    var error:String?
    
    func getFlyPool(address: String,
                    coin: String,
                    callback: (([CellContentModel], String?)->())?)
    {
        var api = ""
        var divider = 0.0
        if (coin == Currency.zec)
        {
            api = APIs.flyPoolAPI(address: address)
            divider = 100000000
        }
        else {
            api = APIs.ethermineAPI(coin: coin, address: address)
            divider = 1000000000000000000
        }
        
        Alamofire.request(api + address).responseJSON(){
            if let value = $0.result.value
            {
                let json = JSON(value)
                if (json["rounds"].array != nil &&
                    json["rounds"].arrayValue.count != 0) // correct api
                {
                    self.error = nil
                    
                    let address = json["address"].stringValue
                    
                    let unpaid = json["unpaid"].doubleValue / divider
                    
                    
                    var contents:[CellContentModel] = []
                    contents.append( CellContentModel(name: "Address",
                                                      value: address)  )
                    
                }
                else
                {
                    self.error = "\(coin.uppercased()) Server API Error !"
                    print(self.error!)
                    callback?([], self.error!)
                    
                }
            }
            else
            {
                self.error = "Server is Unavailable"
                print(self.error!)
                callback?([], self.error!)
                
            }
        }
    }
}
