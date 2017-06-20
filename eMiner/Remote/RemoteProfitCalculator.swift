//
//  RemoteProfitCalculator.swift
//  eMiner
//
//  Created by Issarapong Poesua on 6/20/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire
import RxCocoa
import SwiftyJSON
class RemoteProfitCalculator: NSObject
{
    func calculateProfit(hardware: HardwareModel,
                         elCost: Double) -> Observable<ProfitModel>
    {
        return Observable.create(){ observer in
            
            var params: [String: String] = [:]
            
            params["hwname"] = hardware.name
            params["icost"] = "\(hardware.price)"
            params["power"] = "\(hardware.power)"
            
            params["elcost"] = "\(elCost)"
            
            for i in 0...hardware.speeds.count - 1
            {
                params["fa\(i)"] = String(hardware.speeds[i])
            }
            
            Alamofire
                .request(APIs.calculateProfit())
                .responseJSON(){
                    guard let value = $0.result.value
                        else { observer.onError($0.error!); return }
                    let json = JSON(value)
                    
                    if (json["error"] == nil)
                    {
                        var profitModel = ProfitModel(id: json["current_algo"].stringValue,
                                                      profit: json["current_prof"].doubleValue)
                        observer.onNext(profitModel)
                    }
            }
            return Disposables.create()
        }
        
    }
}
