//
//  ReportViewController.swift
//  eMiner
//
//  Created by Issarapong Poesua on 6/8/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class ReportViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    var email: String { return emailTextField.text ?? "" }
    var descriptionText: String { return descriptionTextField.text ?? ""}
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func send(_ sender: Any) {
        
            }
    


}
