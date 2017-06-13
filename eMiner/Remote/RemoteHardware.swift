//
//  RemoteHardware.swift
//  eMiner
//
//  Created by Issarapong Poesua on 6/12/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import JavaScriptCore
class RemoteHardware: NSObject
{
    var error: String?
    func getHardwareList(callback: (([HardwareModel], String?) -> ())? )
    {
        Alamofire.request(APIs.ownNiceHashHardwareList()).responseArray() { (res: DataResponse<[HardwareModel]>) in
            
            if let hardwares = res.result.value
            {
                
                callback?(hardwares, nil)
            }
            else
            {
                self.error = "Server is unavailable right now."
                
                callback?([], self.error!)
            }
        }
        
    }
    

    
    
}
