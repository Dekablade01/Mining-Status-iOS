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
import RxSwift
import RxCocoa
class RemoteHardware: NSObject
{
    var hardwares: [HardwareModel] = []
    
    func getHardwaresList() -> Observable<[HardwareModel]>
    {
        return Observable.create(){ observer in
            
            Alamofire.request(APIs.ownNiceHashHardwareList()).responseArray() { (res: DataResponse<[HardwareModel]>) in
                
                if let hardwares = res.result.value
                {
                    self.hardwares = hardwares
                    observer.onNext(hardwares)
                }
                else
                {
                    observer.onError(res.error!)
                }
            }
            return Disposables.create()
        }
        
    }
    
}
