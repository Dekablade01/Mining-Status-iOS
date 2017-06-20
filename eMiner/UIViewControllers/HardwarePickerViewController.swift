//
//  HardwarePickerViewController.swift
//  eMiner
//
//  Created by Issarapong Poesua on 6/19/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import PickerView
class HardwarePickerViewController: BlueNavigationBarViewController
{

    private var isAddedConstraints = false
    var selectedCurrencyCode = ""
    
    let pickerView = PickerView(frame: CGRect.zero)
    let dataSource = HardwarePickerDataSource()
    let delegate = HardwarePickerViewDelegate()
    
    var hardware: HardwareModel?
    
    var didDismissViewControllerHandler : ((HardwareModel)->())?
    override func viewDidLoad() {
        super.viewDidLoad()
        startActivityIndicator()
        initialPickerView()
        
        self.view.backgroundColor = Colors.grayBackground
        self.view.addSubview(pickerView)
        
        self.view.setNeedsUpdateConstraints()
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem)
    {
        self.dismiss(animated: true, completion: nil)
    }
    override func updateViewConstraints() {
        if (isAddedConstraints == false)
        {
            pickerView.snp.makeConstraints(){
                $0.height.equalTo(self.view)
                $0.width.equalTo(self.view).multipliedBy(0.8)
                $0.center.equalTo(self.view)
            }
            
            isAddedConstraints = true
        }
        super.updateViewConstraints()
    }
    
    
    func initialPickerView()
    {
        delegate.didSelectHandler = {
            self.hardware = $0
        }

        
        pickerView.delegate = delegate 
        pickerView.dataSource = dataSource
        
        
        pickerView.scrollingStyle = .default
        pickerView.selectionStyle  = .defaultIndicator
        pickerView.backgroundColor = Colors.grayBackground
        
    }
    
    
    @IBAction func didPressOnOKButton(_ sender: UIBarButtonItem)
    {

        
        self.didDismissViewControllerHandler?(hardware!)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    

}
