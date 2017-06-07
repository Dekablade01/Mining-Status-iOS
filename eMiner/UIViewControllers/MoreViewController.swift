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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }

    
    @IBAction func openCurrencyPage(_ sender: UIButton)
    {

    }
    func loadCurrency()
    {
        RemoteFactory.remoteFactory.remoteCurrency.loadCurrencies(){
            self.currenciesCode = $0
            self.currenciesName = $1
            self.performSegue(withIdentifier: self.openCurrencyIdentifier, sender: self)
        }
    }
    

}
