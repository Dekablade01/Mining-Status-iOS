//
//  ProfitCalculatorViewController.swift
//  eMiner
//
//  Created by Issarapong Poesua on 6/15/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class ProfitCalculatorViewController: BlueNavigationBarViewController
{

    @IBOutlet weak var minerNameTextLabel: UITextField!
    
    @IBOutlet weak var numberOfMinersTextLabel: UITextField!
    
    var hardwares: [HardwareModel] = []
    
    var minerName: String {
        get { return minerNameTextLabel.text ?? "" }
        set { minerNameTextLabel.text = newValue }
    }
    var numberOfMiners: Double {
        get { return  Double(numberOfMinersTextLabel.text!) ?? 0.0}
        set { numberOfMinersTextLabel.text = "\(newValue)" }
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()

    }
    
    func getMiners()
    {
        self.startActivityIndicator()
        
        RemoteFactory
            .remoteFactory
            .remoteHardware
            .getHardwareList() { self.hardwares = $0.0  }
    }


    



}
