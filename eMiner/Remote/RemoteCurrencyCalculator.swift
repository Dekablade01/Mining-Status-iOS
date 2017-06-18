//
//  RemoteCurrencyCalculator.swift
//  eMiner
//
//  Created by Issarapong Poesua on 6/10/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import SwiftyJSON
import RxSwift
import RxCocoa

class RemoteCurrencyCalculator: NSObject
{
    static var toCurrency: String { return UserDefaults.standard.value(forKey: "currencyCode") as? String ?? "USD" }
    
    func convert(_ inputValue: Double = 1,
                 from: String,
                 to: String = toCurrency) -> Observable<Double>
    {
        return Observable.create(){ observer in
            
            Alamofire
                .request(APIs.currencyCalculator(from: from,
                                                      to: to))
                .responseJSON(){
                if let value = $0.result.value
                {
                    let json = JSON(value)
                    let price = json["\(to)"].doubleValue
                    print("price from remote :", price)
                    observer.onNext(price)
                    observer.onCompleted()
                }
                else
                {
                    observer.onError($0.error!)
                }
            }
            return Disposables.create()
        }
    }
}
