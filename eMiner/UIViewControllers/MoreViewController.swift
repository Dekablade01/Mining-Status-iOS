//
//  MoreViewController.swift
//  eMiner
//
//  Created by Issarapong Poesua on 6/7/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController
{
    
    
    var openCurrencyIdentifier: String { return "OpenCurrency"}
    var currenciesCode:[String] = []
    var currenciesName:[String] = []
    var subject = ""
    var body = ""
    var email = ""
    
    override func viewDidLoad()
    {
        
        
    }
    
    @IBAction func sendNeedHelp(_ sender: Any) {
        
        var subject = "Miner : I need help !"
        subject = subject.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        
        var body = ""
        body = body.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        let url = URL(string:
            "mailto:dekablade01@gmail.com" +
            "?subject=" + subject +
            "&body=" + body)!
        
        UIApplication.shared.openURL(url)
        
    }
    @IBAction func sendPoolRequest(_ sender: Any) {
        
        var subject = "Miner : I need more pool !"
        subject = subject.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        
        var body = "Poolname(url) : \n" + "coins : "
        body = body.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        let url = URL(string:
            "mailto:dekablade01@gmail.com" +
                "?subject=" + subject +
                "&body=" + body)!
        
        UIApplication.shared.openURL(url)
        
        
    }
    
    
    
    
    
    
    
}
