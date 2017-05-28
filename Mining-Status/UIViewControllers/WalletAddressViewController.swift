//
//  WalletAddressViewController.swift
//  eMiner
//
//  Created by Issarapong Poesua on 5/28/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import RealmSwift

class WalletAddressViewController: UIViewController
{
    var service: ServiceModel {
        get {return AddServiceSingleton.sharedInstance.serviceModel }
    }

    @IBOutlet weak var walletAddressTextField: UITextField!
    var walletAddress:String {return walletAddressTextField.text ?? ""}
    
    @IBAction func submit(_ sender: UIBarButtonItem)
    {
        guard (walletAddress != "" && walletAddress.characters.count > 30)
            else { showAlert(title: "Something Went Wrong",
                             message: "Please Input Your \(service.currency) Wallet Address" ,
                             button: "OK")
                
                return }
        AddServiceSingleton.sharedInstance.serviceModel.address = walletAddress
        
        addServiceToRealm(poolName: service.poolname, currency: service.currency, address: service.address)
    }
    
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        
        walletAddressTextField.placeholder = "Your \(service.currency) Wallet Address"
        
        walletAddressTextField.becomeFirstResponder()

    }
    
    func showAlert(title: String, message: String, button: String)
    {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: button,
                                      style: .default,
                                      handler: nil))
        self.present(alert,
                     animated: true,
                     completion: nil)
    }
    
    func addServiceToRealm(poolName: String, currency: String, address: String)
    {
        let realm = try! Realm()
        
        let service = ServiceModel()
        service.address = address
        service.currency = currency
        service.poolname = poolName
        
        try! realm.write {
            realm.add(service)
        }
        
        AddServiceSingleton.sharedInstance.clear()
        self.dismiss(animated: true, completion: nil)
    }



}