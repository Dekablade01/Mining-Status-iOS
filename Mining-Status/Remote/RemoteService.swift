//
//  RemoteService.swift
//  Mining-Status
//
//  Created by Issarapong Poesua on 5/26/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import RxSwift
import AlamofireObjectMapper
import Alamofire

class RemoteService: NSObject {

    func loadService(_ callback: (([PoolModel])->())?)
    {
        Alamofire.request(API.poolList).responseArray() { (response: DataResponse<[PoolModel]>) in
        
            guard let poolModels = response.result.value
                else { return print("parsing poolModel Fail")}
            callback?(poolModels)
            for pool in poolModels {
                print(pool.currencies)
            }
            
            
        }
    }
    
}
