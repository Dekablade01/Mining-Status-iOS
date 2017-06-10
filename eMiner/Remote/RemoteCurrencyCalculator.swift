//
//  RemoteCurrencyCalculator.swift
//  eMiner
//
//  Created by Issarapong Poesua on 6/10/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RemoteCurrencyCalculator: NSObject
{
    
    var error: String?
    
    static var toCurrency: String { return UserDefaults.standard.value(forKey: "currencyCode") as? String ?? "USD" }
    func convert(_ inputValue: Double,
                 from: String,
                 to: String = toCurrency, callback: ((Double, String?)->())?)
    {
        let from = from.uppercased()
        let to = to.uppercased()
        Alamofire.request(API.currencyCalculator + from + "&tsyms=" + to).responseJSON(){
            if let value = $0.result.value
            {
                if ($0.result.isSuccess) // call success
                {
                    let json = JSON(value)
                    if (json["Message"].string == nil) // correct api value
                    {
                        let currencyValue = json[to].doubleValue
                        
                        let calculated = inputValue * currencyValue
                        
                        callback?(calculated, self.error)
        
                    }
                    else
                    {
                        self.error = json["Message"].string
                        callback?(0.0, self.error)
                        print("error : ", self.error!)
                    }
                }
                
            }
            else
            {
                callback?(0.0, "Server is available right now.")
                print("request remote currency error : ", $0.error ?? "")
            }
        }
    }
}
