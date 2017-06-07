//
//  RemoteNiceHash.swift
//  eMiner
//
//  Created by Issarapong Poesua on 6/5/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import SwiftSoup
import Alamofire
import SwiftyJSON
class RemoteNiceHash: NSObject
{
    let webView = UIWebView(frame: CGRect.zero)
    var payout = ""
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
            print(self.payout)
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
