//
//  WalletAddressViewController.swift
//  eMiner
//
//  Created by Issarapong Poesua on 5/28/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import RealmSwift

class WalletAddressViewController: BlueNavigationBarViewController
{
    var service: ServiceModel {
        get {return AddServiceSingleton.sharedInstance.serviceModel }
    }
    
    @IBOutlet weak var walletAddressTextField: UITextField!
    var walletAddress:String { return walletAddressTextField.text ?? ""}
    
    @IBAction func submit(_ sender: UIBarButtonItem)
    {
        
        AddServiceSingleton
            .sharedInstance
            .serviceModel
            .address = self.walletAddress
        
        self.addServiceToRealm(poolName: self.service.poolname,
                               currency: self.service.currency,
                               address: self.service.address)
    }
    
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        
        walletAddressTextField.placeholder = "Your \(service.currency) Wallet Address"
        
        walletAddressTextField.becomeFirstResponder()
        
    }
    
    func addServiceToRealm(poolName: String, currency: String, address: String)
    {
        let realm = try! Realm()
        
        let service = ServiceModel()
        service.id = randomString(length: 20)
        service.address = address
        service.currency = currency
        service.poolname = poolName
        
        
        try! realm.write {
            realm.add(service)
        }
        
        AddServiceSingleton.sharedInstance.clear()
        self.dismiss(animated: true, completion: nil)
    }
    
    func randomString(length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    
    
    
}
