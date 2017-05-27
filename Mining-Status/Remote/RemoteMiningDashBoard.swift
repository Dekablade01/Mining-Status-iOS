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
    
    func loadDetail(_ callback: (([CellContentModel])->())?)
    {
        Alamofire.request(API.dashboard)
            .responseArray() { (res: DataResponse<[CellContentModel]>) in
        
                guard let contents = res.result.value
                    else { return }
                
                callback?(contents)
                
        }
    }

}
