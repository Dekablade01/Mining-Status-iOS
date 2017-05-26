//
//  RemoteMiningDashBoard.swift
//  Mining-Status
//
//  Created by Issarapong Poesua on 5/26/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class RemoteMiningDashBoard: NSObject {
    
    func loadDetail(_ callback: ((MiningDashBoardResponse)->())?)
    {
        Alamofire.request(API.dashboard)
            .responseObject() { (response: DataResponse<MiningDashBoardResponse>) in
            
            guard let miningDashBoardResponse = response.result.value
                else { return } 
            
            callback?(miningDashBoardResponse)

        }
    }

}
