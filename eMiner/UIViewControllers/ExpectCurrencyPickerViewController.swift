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

class ExpectCurrencyPickerViewController: BlueNavigationBarViewController {
    

    
    private var isAddedConstraints = false
    var selectedCurrencyCode = ""

    let pickerView = PickerView(frame: CGRect.zero)
    let dataSource = CurrencyPickerDataSource()
    let delegate = ExpectCurrencyPickerViewDelegate()
    override func viewDidLoad() {
        super.viewDidLoad()
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
        if (dataSource.currencies.count == 0)
        {
            self.startActivityIndicator()
        }

        delegate.didSelectHandler = {
            self.selectedCurrencyCode = $0.symbol
        }
        
        pickerView.delegate = delegate
        pickerView.dataSource = dataSource
        
        pickerView.scrollingStyle = .default
        pickerView.selectionStyle  = .defaultIndicator
        pickerView.backgroundColor = Colors.grayBackground
        
        var currentCurrency = UserDefaults.standard.string(forKey: "currencyCode") ?? "USD"
        
        if (currentCurrency == "" )
        { currentCurrency = "USD" }
        
        pickerView.currentSelectedRow = RemoteFactory
            .remoteFactory
            .remoteCurrencies
            .isAtIndex(symbol: currentCurrency)
        
    }
    
    
    @IBAction func didPressOnOKButton(_ sender: UIBarButtonItem)
    {

        UserDefaults.standard.set(selectedCurrencyCode, forKey: "currencyCode")
        UserDefaults.standard.synchronize()
        
        self.dismiss(animated: true, completion: nil)
    }
    
}




