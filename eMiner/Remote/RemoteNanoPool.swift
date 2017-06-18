//
//  RemoteNanoPool.swift
//  eMiner
//
//  Created by Issarapong Poesua on 6/11/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RxSwift
import RxCocoa

class RemoteNanoPool: NSObject
{

    
    var disposeBag = DisposeBag()
    
    func getNanoPool(address: String, coin: String) -> Observable<[CellContentModel]>
    {
        return Observable.create(){ observer in
            
            Alamofire
                .request(APIs.nanoPoolGeneral(coin: coin,
                                              address: address))
                .responseJSON(){ nanoPoolResponse in
                    
                    guard let value = nanoPoolResponse.result.value else { observer.onError(nanoPoolResponse.error!); return  }
                    
                    let json = JSON(value)
                    let data = json["data"]
                    
                    let address = data["account"].stringValue
                    print("addr: ", address)
                    
                    var hashRateString = ""
                    var avgHashRateString = ""
                    
                    
                    if (coin == Currency.sia || coin == Currency.etc || coin == Currency.eth)
                    {
                        hashRateString = String((data["hashrate"].doubleValue / 1000).roundTo(places: 2)) + " GH/s"
                        avgHashRateString = String((data["avgHashrate"]["h1"].doubleValue / 1000).roundTo(places: 2)) + " GH/s"
                        
                        
                    }
                    else if (coin == Currency.zec)
                    {
                        hashRateString = String((data["hashrate"].doubleValue / 1000).roundTo(places: 2)) + " KS/s"
                        avgHashRateString = String((data["avgHashrate"]["h1"].doubleValue / 1000).roundTo(places: 2)) + " KS/s"
                    }
                    
                    var balance = data["balance"].doubleValue
                    if (balance > 0)
                    {
                        if (coin == Currency.sia)
                        {
                            balance = data["balance"].doubleValue.roundTo(places: 1)
                        }
                        else
                        {
                            balance = data["balance"].doubleValue.roundTo(places: 6)
                            
                        }
                    }
                    
                    let workersDetail = data["workers"].arrayValue
                    
                    var workers:[WorkerModel] = []
                    
                    for workerDetail in workersDetail
                    {
                        let worker = WorkerModel(name: workerDetail["id"].stringValue,
                                                 hashRate: workerDetail["hashrate"].doubleValue,
                                                 avgHashRate: workerDetail["avg_h1"].doubleValue)
                        workers.append(worker)
                    }
                    
                    let activeWorkers = workers.filter() { $0.hashRate != 0 }
                    
                    var contents: [CellContentModel] = []
                    contents.append(CellContentModel(name: "Address", value: address))
                    contents.append(CellContentModel(name: "Workers", value: activeWorkers.count))
                    contents.append(CellContentModel(name: "HashRate", value: hashRateString))
                    contents.append(CellContentModel(name: "AvgHashRate", value: avgHashRateString))
                    contents.append(CellContentModel(name: "Unpaid", value: balance))
                    
                    var coinForExchange = ""
                    if (coin == Currency.sia) { coinForExchange = "SC" } else { coinForExchange = coin }
                    
                    RemoteFactory
                        .remoteFactory
                        .remoteCurrencyCalculator
                        .convert(from: coinForExchange)
                        .subscribe(onNext: { price in
                            contents
                                .append(CellContentModel(
                                    name: "In \(RemoteCurrencyCalculator.toCurrency.uppercased())"
                                    , value: price))
                            observer.onNext(contents)
                            observer.onCompleted()
                        } ,
                                   
                                   onError: { observer.onError($0) } )
                        .addDisposableTo(self.disposeBag)
            }
            
            
            return Disposables.create()
        }
    }
}



