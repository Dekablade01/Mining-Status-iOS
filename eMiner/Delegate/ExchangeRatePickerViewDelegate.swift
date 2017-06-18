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
    var currencyExchangeRateCaller: CurrencyExchangeRateCaller  { return SingletonExchangeRate.sharedInstance.currencyExchangeRateCaller }
    
    var didSelectHandlerWithSource: (((String), (CurrencyExchangeRateCaller))->())?
    override func pickerView(_ pickerView: PickerView, didSelectRow row: Int, index: Int)
    {
        if currencyExchangeRateCaller == .from
        {
            SingletonExchangeRate.sharedInstance.fromCurrency = currencies[index].symbol
        }
        if currencyExchangeRateCaller == .to
        {
            SingletonExchangeRate.sharedInstance.toCurrency = currencies[index].symbol
        }
    }
}
