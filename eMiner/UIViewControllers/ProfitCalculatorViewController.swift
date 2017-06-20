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
    var openHardwarePickerViewControllerSegue: String { return "openHardwarePickerViewControllerSegue" }
    var didPressedOnButton = false
    
    @IBOutlet weak var numberOfMinersTextField: TextField!
    var hardware: HardwareModel?
    
    var minerNameForTextLabel: String {
        get { return minerNameTextLabel.text ?? "" }
        set { minerNameTextLabel.text = newValue }
    }
    var numberOfMiners: Int {
        get { return  Int(numberOfMinersTextField.text!) ?? 0}
        set { numberOfMinersTextField.text = "\(newValue)" }
    }
    
    @IBOutlet weak var minerLabelContainer: UIView!
    @IBOutlet weak var minerNameContainer: UIView!
    
    @IBOutlet weak var numbersLabelContainer: UIView!
    @IBOutlet weak var numberContainer: UIView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        loadHardwares()
        setupColors()
    }
    
    func setupColors()
    {

        numberOfMinersTextField.placeholder = "Email"
        numberOfMinersTextField.placeholderActiveColor = .white
        numberOfMinersTextField.placeholderNormalColor = .white

        numberOfMinersTextField.detail = "Error, incorrect email"
        
        minerLabelContainer.backgroundColor = Color.blue.darken2
        minerNameContainer.backgroundColor = Color.blue.darken1
        minerNameTextLabel.adjustsFontSizeToFitWidth = true
        numbersLabelContainer.backgroundColor = Color.blue.darken1
        numberContainer.backgroundColor = Color.blue.base
    }
    @IBAction func openHardwarePickerViewController(_ sender: UIButton)
    {
        
        
        
    }
    func loadHardwares()
    {
        self.startActivityIndicator()
        _ = RemoteFactory
            .remoteFactory
            .remoteHardware
            .getHardwaresList()
            .subscribe(onNext: { _ in self.stopActivityIndicator() } ,
                       onError: { self.showAlert(title: "Something went wrong",
                                                 message: $0.localizedDescription,
                                                 button: "OK") })
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String,
                                     sender: Any?) -> Bool
    {
        if (identifier == openHardwarePickerViewControllerSegue)
        {
            return true
        }
        else { return false }
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        guard let navigationController = segue.destination as? UINavigationController
            
            else { return }
        
        
        guard let viewController = navigationController.viewControllers.first as? HardwarePickerViewController
            else { return }
        
        viewController.didDismissViewControllerHandler = {
            self.minerNameForTextLabel = $0.name
            self.hardware = $0
        }
        
        
    }
    
}
extension ProfitCalculatorViewController: UITextFieldDelegate
{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

