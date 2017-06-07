//
//  RemoteWalletValidator.swift
//  eMiner
//
//  Created by Issarapong Poesua on 6/6/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RemoteWalletValidator: NSObject
{
    func validateWallet(coin: String, address: String, callback: ((Bool)->())?)
    {
        
        let url = API.walletValidator + coin + "/" + address
        
        print("coin ", coin)
        print("address ", address)
        print("url ", url)
        Alamofire.request(url).responseJSON(){
            print($0)
            if let value = $0.result.value
            {
                let json = JSON(value)
                let status = json["status"].bool ?? false
                callback?(status)
            }
        }
    }
}
