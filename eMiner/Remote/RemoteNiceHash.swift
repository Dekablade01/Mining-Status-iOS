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
class RemoteNiceHash: NSObject
{
    var algorithmsDict: [String: String] = [:]
    var error: String?
    
    var workers: [String] = []
    var algos: [String] = []
    var unpaid: Double = 0.0
    var unpaidInCurrency: Double = 0.0
    var currencyValue: Double = 0.0
    
    var toCurrency: String { return RemoteCurrencyCalculator.toCurrency }
    
    func clearValue()
    {
        workers.removeAll()
        algos.removeAll()
        unpaidInCurrency = 0
        unpaid = 0
        currencyValue = 0
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
    }

    let webView = UIWebView(frame: CGRect.zero)
    var payout = "" {
        didSet { if (payout == "N/A" && oldValue != ""){ payout = oldValue} }
    }
    
    var sec = 0
    var tryAgain:Bool? = true
    
    var didFinishLoadingPayoutHandler: ((String)->())?

    func getPayoutDate(address: String)
    {
        webView.delegate = self
        
        let url = URL(string: API.nicehashDashBoard + address)!
        
        let request = URLRequest(url: url)
        
        webView.loadRequest(request)
    }
    
    func getAlgorithmDictionary () -> [String:String]
    {
        return algorithmsDict
    }

    
    func getNicehashDetail(address: String,
                           callback: (([CellContentModel], String?)->())? )
    {
        
        getPayoutDate(address: address)
        
        Alamofire.request(API.niceHashStatProvider + address).responseJSON(){
            
            if let value = $0.result.value
            {
                if ($0.result.isSuccess)
                {
                    let json = JSON(value)
                    
                    if (json["result"]["error"].string == nil)
                    {
                        let result = json["result"]
                        let address = result["addr"].stringValue
                        let stats = result["stats"].array ?? []
                        var algos:[String] = []
                        
                        for stat in stats
                        {
                            self.unpaid += Double((stat["balance"].stringValue)) ?? 0.0
                            
                            let algo = String(stat["algo"].intValue)
                            algos.append(algo)
                        }
                        
                        self.getNicehashWorkers(address: address, algos: algos){ _ in
                            
                            RemoteFactory
                                .remoteFactory
                                .remoteCurrencyCalculator
                                .convert(self.unpaid,
                                         from: "BTC"){
                                            self.unpaidInCurrency = $0.0
                                            self.error = $0.1
                                            
                                            self.didFinishLoadingPayoutHandler = { payout in
                                                
                                                self.payout = (payout as NSString).substring(to: 10)
                                                
                                                var contents: [CellContentModel] = []
                                                
                                                contents.append(CellContentModel(name: "Address",
                                                                                 value: address))
                                                contents.append(CellContentModel(name: "Workers",
                                                                                 value: self.workers.count))
                                                contents.append(CellContentModel(name: "Unpaid",
                                                                                 value: self.unpaid.roundTo(places: 7)))
                                                contents.append(CellContentModel(name: "In \(self.toCurrency)",
                                                    value: self.unpaidInCurrency.roundTo(places: 2)))
                                                
                                                contents.append(CellContentModel(name: "Est. Payout",
                                                                                 value: self.payout))
                                                
                                                callback?(contents, self.error)
                                                self.clearValue()
                                            }
                            }
                        }
                        
                    }
                    else
                    {
                        self.error = json["result"]["error"].stringValue 
                        callback?([], self.error)
                    }
                }
                else
                {
                    callback?([], "dont' know error")
                }
            }
            else
            {
                callback?([], "Server is available right now.")
            }
        }

    }
    
    func getNicehashWorkers(address: String,
                            algos: [String],
                            callback: (([String], [String], String?)->())?)
    {
        var receivedAlgorithm = 0
    
        for algo in algos
        {
            
            Alamofire.request(API.niceHashStatProviderWorkers + address + "&algo=" + algo).responseJSON(){
                if let value = $0.result.value
                {
                    let json = JSON(value)
                    
                    if (json["result"]["error"].string == nil) // success
                    {
                        receivedAlgorithm += 1
                        
                        let result = json["result"]
                        let workersJSON: [Any] = result["workers"].arrayValue
                        if (workersJSON.count != 0)
                        {
                            let workersDetail = JSON(workersJSON)

                            self.algos.append(self.algorithmsDict[algo] ?? "")
                            
                            
                            for i in 0...workersDetail.count-1
                            {
                                let workerName = workersDetail[i].first!.1.stringValue
                                self.workers.append(workerName)
                            }
                            
                        }
                        
                        if (receivedAlgorithm == algos.count)
                        {
                            self.workers = self.workers.uniqueElements
                            callback?(self.workers, self.algos, nil)
                        }
                    }
                    else
                    {
                         self.error = json["result"]["error"].stringValue
                        callback?([],[], self.error)
                    }
                }
            }
            
        }
        
    }

}

extension RemoteNiceHash : UIWebViewDelegate
{
    
    func webViewDidFinishLoad(_ webView: UIWebView)
    {
        getPayoutDateFromLoadingWebSite(1)
    }
    func getPayoutDateFromLoadingWebSite(_ wait: Int)
    {
        var jsString: String { return "document.querySelector('#next-payout-time').innerHTML" }
        
        let deadlineTime = DispatchTime.now() + .seconds(wait)
        
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            
            self.payout = self.webView.stringByEvaluatingJavaScript(from: jsString) ?? "no value"
            if (self.payout == "N/A" && self.tryAgain == true )
            {
                self.getPayoutDateFromLoadingWebSite(1)
                self.sec += wait
                print(self.sec)
                if (self.sec == 4)
                {
                    self.tryAgain = false
                }
            }
            else if (self.tryAgain == nil)
            {
                self.didFinishLoadingPayoutHandler?("")
            }
            else
            {
                self.didFinishLoadingPayoutHandler?(self.payout)
            }
        }
    }
}
