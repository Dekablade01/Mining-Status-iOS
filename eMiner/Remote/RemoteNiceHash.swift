//
//  RemoteNiceHash.swift
//  eMiner
//
//  Created by Issarapong Poesua on 6/5/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RxSwift
import RxCocoa

class RemoteNiceHash: NSObject
{
    var algorithmsDict: [String: String] = [:]
    var error: String?
    
    var workers: [WorkerModel] = []
    var algos: [String] = []
    var unpaid: Double = 0.0
    var unpaidInCurrency: Double = 0.0
    var currencyValue: Double = 0.0
    let webView = UIWebView(frame: CGRect.zero)
    var payout = "N/A"
    var profit: Double = 0.0
    var sec = 0
    
    var disponseBag = DisposeBag()
    
    var tryAgain = true
    
    var toCurrency: String { return RemoteCurrencyCalculator.toCurrency }
    
    func clearValue()
    {
        workers.removeAll()
        algos.removeAll()
        unpaidInCurrency = 0
        unpaid = 0
        currencyValue = 0
        sec = 0
        tryAgain = true
    }
    
    override init()
    {
        algorithmsDict["0"] = "Scrypt"
        algorithmsDict["1"] = "SHA256"
        algorithmsDict["2"] = "ScryptNf"
        algorithmsDict["3"] = "X11"
        algorithmsDict["4"] = "X13"
        algorithmsDict["5"] = "Keccak"
        algorithmsDict["6"] = "X15"
        algorithmsDict["7"] = "Nist5"
        algorithmsDict["8"] = "NeoScrypt"
        algorithmsDict["9"] = "Lyra2RE"
        algorithmsDict["10"] = "WhirlpoolX"
        algorithmsDict["11"] = "Qubit"
        algorithmsDict["12"] = "Quark"
        algorithmsDict["13"] = "Axiom"
        algorithmsDict["14"] = "Lyra2REv2"
        algorithmsDict["15"] = "ScryptJaneNf16"
        algorithmsDict["16"] = "Blake256r8"
        algorithmsDict["17"] = "Blake256r14"
        algorithmsDict["18"] = "Blake256r8vnl"
        algorithmsDict["19"] = "Hodl"
        algorithmsDict["20"] = "DaggerHashimoto"
        algorithmsDict["21"] = "Decred"
        algorithmsDict["22"] = "CryptoNight"
        algorithmsDict["23"] = "Lbry"
        algorithmsDict["24"] = "Equihash"
        algorithmsDict["25"] = "Pascal"
        algorithmsDict["26"] = "X11Gost"
        algorithmsDict["27"] = "Sia"
        algorithmsDict["28"] = "Blake2s"

    }
    
    
    
    var didFinishLoadingPayoutHandler: ((String, Double)->())?
    
    func getPayoutDate(address: String)
    {
        webView.delegate = self
        
        let url = URL(string: APIs.niceHashDashboard(address: address))!
        
        let request = URLRequest(url: url)
        
        webView.loadRequest(request)
    }
    
    func getAlgorithmDictionary () -> [String:String]
    {
        return algorithmsDict
    }
    
    
    func getNicehashDetail(address: String) -> Observable<[CellContentModel]>
    {
        getPayoutDate(address: address)
        
        return Observable.create(){ observer in
            Alamofire
                .request(APIs.niceHashStatProvider(address: address))
                .responseJSON(){
                    guard let value = $0.result.value else { observer.onError($0.error!); return }
                    
                    let json = JSON(value)
                    
                    self.error = nil
                    let result = json["result"]
                    let address = result["addr"].stringValue
                    let stats = result["stats"].array ?? []
                    var algos:[String] = []
                    var hashRates: [Double] = []
                    
                    for stat in stats
                    {
                        self.unpaid += Double((stat["balance"].stringValue)) ?? 0.0
                        let algo = String(stat["algo"].intValue)
                        let hashrate = stat["accepted_speed"].doubleValue
                        hashRates.append(hashrate)
                        algos.append(algo)
                    }
                    
                    RemoteFactory
                        .remoteFactory
                        .remoteNiceHash
                        .getNicehashWorkers(address: address,
                                            algos: algos)
                        .subscribe(onNext: { workers in
                            
                            RemoteFactory
                                .remoteFactory
                                .remoteCurrencyCalculator
                                .convert(from: "BTC")
                                .subscribe(onNext:
                                    { price in
                                        
                                        self.unpaidInCurrency = price * self.unpaid
                                        
                                        self.didFinishLoadingPayoutHandler = { response in

                                            
                                            print("response : ", response.0)
                                            if(response.0.characters.count > 5)
                                            {
                                                self.payout = (response.0 as NSString).substring(to: 10) 
                                            }
                                            else if(self.payout.characters.count > 5)
                                            {
                                                
                                            }

                                            else
                                            {
                                                self.payout = "N/A"
                                            }
                                            
                      
                                            
                                            var contents: [CellContentModel] = []
                                            
                                            contents.append(CellContentModel(name: "Address",
                                                                             value: address))
                                            contents.append(CellContentModel(name: "Workers",
                                                                             value: self.workers.count))
                                            contents.append(CellContentModel(name: "Unpaid",
                                                                             value: self.unpaid.roundTo(places: 7)))
                                            contents.append(CellContentModel(name: "In \(self.toCurrency)",
                                                value: self.unpaidInCurrency.roundTo(places: 2)))
                                            
                                            for i in 0...algos.count-1
                                            {
                                                if (hashRates[i] > 0)
                                                {
                                                    let hashRateString = self.getNiceHashDivideOrTimeForStandard(hashrate: hashRates[i],
                                                                                                                 algo: Int(algos[i])!)
                                                    
                                                    
                                                    contents.append(CellContentModel(name: self.algorithmsDict[algos[i]]!,
                                                                                     value: hashRateString))
                                                }
                                            }
                                            
                                            
                                            
                                            contents.append(CellContentModel(name: "Est. Payout",
                                                                             value: self.payout))
                                            observer.onNext(contents)
                                            observer.onCompleted()
                                        }
                                }
                                    , onError: { observer.onError($0) } )
                                .addDisposableTo(self.disponseBag)
                        }, onError: { observer.onError($0)} )
                        .addDisposableTo(self.disponseBag)     
            }
            return Disposables.create()
        }
    }
    
    
    
    func getNicehashWorkers(address: String, algos: [String]) -> Observable<[WorkerModel]>
    {
        var receivedAlgorithm = 0
        
        return Observable.create(){ observer in
            for algo in algos
            {
                Alamofire.request(APIs.niceHashStatProviderWorker(address: address, algo: algo)).responseJSON(){
                    guard let value = $0.result.value else { observer.onError($0.error!); return }
                    receivedAlgorithm += 1
                    let json = JSON(value)
                    
                    let result = json["result"]
                    let workersJSON: [Any] = result["workers"].arrayValue
                    //                    let stats = json["result"]["stats"].array
                    if (workersJSON.count != 0)
                    {
                        let workersDetail = JSON(workersJSON)
                        
                        self.algos.append(self.algorithmsDict[algo] ?? "")
                        
                        
                        for i in 0...workersDetail.count-1
                        {
                            let workerName = workersDetail[i].first!.1.stringValue
                            let algorithm = self.algorithmsDict[algo] ?? ""
                            //                            let hashrate = json["result"]["stats"][i]["accepted_speed"].doubleValue
                            //                            let balance = json["result"]["stats"][i]["balance"].doubleValue
                            
                            let worker = WorkerModel(name: workerName,
                                                     algorithm: [algorithm])
                            self.workers.append(worker)
                        }
                        
                    }
                    if (receivedAlgorithm == algos.count)
                    {
                        self.workers = self.workers.uniqueElements
                        observer.onNext(self.workers)
                    }
                }
            }
            return Disposables.create()
        }
    }
    
    
    func getNiceHashDivideOrTimeForStandard(hashrate: Double, algo: Int) -> String
    {
        var result = ""
        let tera = [1]
        let giga = [16,17,18,21,23,25,27]
        let mega = [0,2,3,4,5,6,7,8,9,10,11,12,14,20,26]
        let kilo = [13,15,19,22]
        let hash = [24]
        
        if ( tera.contains(algo) )
        {
            let value = (hashrate / 1000).roundTo(places: 1)
            result = "\(value) TH/s"
            return result
            
        }
        if (giga.contains(algo))
        {
            let value = (hashrate * 1).roundTo(places: 1)
            result = "\(value) GH/s"
            return result
            
        }
        if (mega.contains(algo))
        {
            let value = (hashrate * 1000).roundTo(places: 1)
            result = "\(value) MH/s"
            return result
            
        }
        if (kilo.contains(algo))
        {
            let value = (hashrate * 1000000).roundTo(places: 1)
            result = "\(value) KH/s"
            return result
            
        }
        if (hash.contains(algo))
        {
            let value = (hashrate * 1000000).roundTo(places: 2)
            result = "\(value) KS/s"
            return result
            
        }
        else { return "" }
    }
    
}

extension RemoteNiceHash : UIWebViewDelegate
{
    
    func webViewDidFinishLoad(_ webView: UIWebView)
    {
        getPayoutDateAndProfitFromLoadingWebSite(1)
    }
    func getPayoutDateAndProfitFromLoadingWebSite(_ wait: Int)
    {
        var payoutJSString: String { return "document.querySelector('#nextPayoutTime').innerHTML" }
        var profitJSString: String { return "document.querySelector('#total-profitability').innerHTML" }
        
        
        print("tryagain : ", tryAgain)
        
        let deadlineTime = DispatchTime.now() + .seconds(wait)
        
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            if (self.payout != "N/A")
            {
                self.tryAgain = false
                self.didFinishLoadingPayoutHandler?(self.payout, self.profit)
            }
            if (self.payout == "N/A")
            {
                let payout = self.webView.stringByEvaluatingJavaScript(from: payoutJSString) ?? "N/A"
                let profitString = self.webView.stringByEvaluatingJavaScript(from: profitJSString) ?? "0.0"
                let profit = Double(profitString) ?? 0.0
                
                if (self.sec == 3)
                {
                    self.tryAgain = false
                }
                if (self.tryAgain == true && payout == "N/A")
                {
                    self.getPayoutDateAndProfitFromLoadingWebSite(1)
                    self.sec += 1
                }
                if (payout != "N/A")
                {
                    self.tryAgain = false
                }
                if (self.tryAgain == false)
                {
                    self.payout = payout
                    self.didFinishLoadingPayoutHandler?(payout, profit)
                }
            }
        }
    }
}
