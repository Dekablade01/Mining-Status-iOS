//
//  RemoteCurrency.swift
//  eMiner
//
//  Created by Issarapong Poesua on 6/7/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RxSwift
import RxCocoa

class RemoteCurrencies: NSObject {
    
    var currencies: [CurrencyModel] = []{
        didSet { print("currencies : ", currencies)}
    }
    
    func loadCurrencies() -> Observable<[CurrencyModel]>
    {
        return Observable.create(){ observer in
            Alamofire
                .request(APIs.ownSupportedCurrencies())
                .responseObject(){ (response : DataResponse<CurrenciesDataResponse>) in
                
                    guard let value = response.result.value else { observer.onError(response.error!); return }
                    
                    if (value.status == false)
                    {
                        observer.onError(response.result.error!)
                    }
                    
                    self.currencies = value.currencies
                    observer.onNext(value.currencies)
                    observer.onCompleted()
                    
            }
            return Disposables.create()
        }
    }
    func isAtIndex(symbol: String) -> Int
    {
        for  i in 0...currencies.count-1 {
            if (symbol  == currencies[i].symbol)
            {
                return i
            }
        }
        return 0
    }
    
}


