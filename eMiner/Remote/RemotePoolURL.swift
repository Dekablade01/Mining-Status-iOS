//
//  RemotePoolURL.swift
//  eMiner
//
//  Created by Issarapong Poesua on 6/6/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class RemotePoolURL: NSObject
{
    
    func getURL(pool: String, currency: String,callback: ((String)->())? )
    {
        
        Alamofire.request(API.poolURL + pool + "/" + currency).responseJSON(){ res in
                
                if let result = res.result.value
                {
                    let json = JSON(result)
                    let poolURL = json["url"].string ?? ""
                    
                    callback?(poolURL)
                }
                
        }
    }
    
}
