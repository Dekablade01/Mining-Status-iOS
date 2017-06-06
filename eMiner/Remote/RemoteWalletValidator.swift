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
        print(address)
        Alamofire.request(API.walletValidator + coin + "/" + address).responseJSON(){
            if let value = $0.result.value
            {
                let json = JSON(value)
                let status = json["status"].bool ?? false
                callback?(status)
            }
        }
    }
}
