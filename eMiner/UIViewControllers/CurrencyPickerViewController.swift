//
//  CurrencyPickerViewController.swift
//  eMiner
//
//  Created by Issarapong Poesua on 6/7/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import PickerView
import SnapKit

class CurrencyPickerViewController: UIViewController {
    
    var currenciesCode:[String] { return RemoteFactory.remoteFactory.remoteCurrency.currenciesSymbol }
    var currenciesName:[String] { return RemoteFactory.remoteFactory.remoteCurrency.currenciesName }
    var isAddedConstraints = false
    var selectedCurrencyCode = ""
    var selectedFontSize: CGFloat { return 20 }
    var deSelectedFontSize: CGFloat { return 10 }
    
    let pickerView = PickerView(frame: CGRect.zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialPickerView()
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
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.scrollingStyle = .default
        pickerView.selectionStyle  = .defaultIndicator
        
        var currentCurrency = UserDefaults.standard.string(forKey: "currencyCode") ?? "USD"
        if (currentCurrency == "" ) { currentCurrency = "USD" }
        
        for  i in 0...currenciesCode.count-1 {
            if (currentCurrency == currenciesCode[i])
            {
                 pickerView.currentSelectedRow = i
            }
        }
        
        
    }
    
    
    @IBAction func didPressOnOKButton(_ sender: UIBarButtonItem)
    {
        UserDefaults.standard.set(selectedCurrencyCode, forKey: "currencyCode")
        UserDefaults.standard.synchronize()
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension CurrencyPickerViewController: PickerViewDelegate
{
    func pickerView(_ pickerView: PickerView, didSelectRow row: Int, index: Int)
    {
        selectedCurrencyCode = currenciesCode[index]
    }
    func pickerViewHeightForRows(_ pickerView: PickerView) -> CGFloat {
        return 40
    }
    
    
    func pickerView(_ pickerView: PickerView, styleForLabel label: UILabel, highlighted: Bool) {
        label.textAlignment = .center
        if #available(iOS 8.2, *) {
            if (highlighted) {
                label.font = UIFont.systemFont(ofSize: selectedFontSize,
                                               weight: UIFontWeightLight)
            } else {
                label.font = UIFont.systemFont(ofSize: deSelectedFontSize,
                                               weight: UIFontWeightLight)
            }
        } else {
            if (highlighted) {
                label.font = UIFont(name: "HelveticaNeue-Light",
                                    size: deSelectedFontSize)
            } else {
                label.font = UIFont(name: "HelveticaNeue-Light",
                                    size: selectedFontSize)
            }
        }
        
        if (highlighted) {
            label.textColor = view.tintColor
        } else {
            label.textColor = UIColor(red: 161.0/255.0,
                                      green: 161.0/255.0,
                                      blue: 161.0/255.0,
                                      alpha: 1.0)
        }
    }
    
}

extension CurrencyPickerViewController: PickerViewDataSource
{
    func pickerViewNumberOfRows(_ pickerView: PickerView) -> Int {
        return currenciesName.count
    }
    func pickerView(_ pickerView: PickerView, titleForRow row: Int, index: Int) -> String {
        let name = "\(currenciesCode[index]) - \(currenciesName[index])"
        
        return name
    }
    
}
