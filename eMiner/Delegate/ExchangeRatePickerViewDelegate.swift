//
//  ExchangeRatePickerViewDelegate.swift
//  eMiner
//
//  Created by Issarapong Poesua on 6/15/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import PickerView

class ExchangeRatePickerViewDelegate: ExpectCurrencyPickerViewDelegate
{    
    private var currencyExchangeRateCaller: CurrencyExchangeRateCaller  { return SingletonExchangeRate.sharedInstance.currencyExchangeRateCaller }
    
    var fromCurrencyDidChange: ((String)->())?
    var toCurrencyDidChange: ((String)->())?

    private var fromCurrency = ""  { didSet { fromCurrencyDidChange?(fromCurrency) }  }
    private var toCurrency = "" { didSet { toCurrencyDidChange?(toCurrency) }  }
    var didSelectHandlerWithSource: (((String), (CurrencyExchangeRateCaller))->())?
    override func pickerView(_ pickerView: PickerView,
                             didSelectRow row: Int, index: Int)
    {
        if currencyExchangeRateCaller == .from
        {
            fromCurrency = currencies[index].symbol

            
        }
        if currencyExchangeRateCaller == .to
        {
            
            toCurrency = currencies[index].symbol
            
//            SingletonExchangeRate
//                .sharedInstance
//                .toCurrency = currencies[index].symbol
        }
    }
}
