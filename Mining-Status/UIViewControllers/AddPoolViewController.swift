//
//  AddPoolViewController.swift
//  eMiner
//
//  Created by Issarapong Poesua on 5/27/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import Then

class AddPoolViewController: UIViewController {

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var confirmButton: UIButton!
    
    var array = ["Fly", "NH"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    func configView()
    {
        let fontsize: CGFloat = 20
        _ = cancelButton.then(){
            $0.layer.cornerRadius = 10
            $0.backgroundColor = BootStrapColor.red
            $0.titleLabel?.font = $0.titleLabel?.font.withSize(fontsize)
            $0.setTitleColor(.white, for: .normal)
            
        }
        _ = confirmButton.then(){
            $0.layer.cornerRadius = 10
            $0.backgroundColor = BootStrapColor.green
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = $0.titleLabel?.font.withSize(fontsize)
        }
    }
    
    @IBAction func dismissViewController(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
extension AddPoolViewController: UIPickerViewDataSource
{
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return array.count
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}
