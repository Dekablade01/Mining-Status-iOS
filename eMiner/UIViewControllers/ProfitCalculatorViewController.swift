//
//  ProfitCalculatorViewController.swift
//  eMiner
//
//  Created by Issarapong Poesua on 6/15/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import Material

class ProfitCalculatorViewController: BlueNavigationBarViewController
{

    
    @IBOutlet weak var minerNameTextLabel: UILabel!
    @IBOutlet weak var numberOfMinersTextLabel: UITextField!
    var hardwares: [HardwareModel] = []
    
    var minerName: String {
        get { return minerNameTextLabel.text ?? "" }
        set { minerNameTextLabel.text = newValue }
    }
    var numberOfMiners: Int {
        get { return  Int(numberOfMinersTextLabel.text!) ?? 0}
        set { numberOfMinersTextLabel.text = "\(newValue)" }
    }
    @IBOutlet weak var minerLabelContainer: UIView!
    @IBOutlet weak var minerNameContainer: UIView!
    
    @IBOutlet weak var numbersLabelContainer: UIView!
    @IBOutlet weak var numberContainer: UIView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupColors()
    }
    
    func getMiners()
    {
        self.startActivityIndicator()
        RemoteFactory
            .remoteFactory
            .remoteHardware
            .getHardwareList() { self.hardwares = $0.0  }
    }
    func setupColors()
    {
        minerLabelContainer.backgroundColor = Color.blue.darken2
        minerNameContainer.backgroundColor = Color.blue.darken1
        
        numbersLabelContainer.backgroundColor = Color.blue.darken1
        numberContainer.backgroundColor = Color.blue.base
    }


    



}
