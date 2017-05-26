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

    func loadService(_ callback: ((ServiceListResponse)->())?)
    {
        Alamofire.request(API.poolList).responseObject() { (response: DataResponse<ServiceListResponse>) in
            
            if let serviceListResponse = response.result.value
            {
                callback?(serviceListResponse)
            }
        }
    }
    
}
