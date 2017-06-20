//
//  SingletonExchangeRate.swift
//  eMiner
//
//  Created by Issarapong Poesua on 6/15/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SingletonExchangeRate: NSObject
{
    static var sharedInstance = SingletonExchangeRate()
    var currencyExchangeRateCaller: CurrencyExchangeRateCaller = .none
    
    var fromCurrencyDidChangeHandler: ((String) -> ())?
    var toCurrencyDidChangeHandler: ((String) -> ())?
    
    var disposeBag = DisposeBag()
    
    override init() {
        super.init()
    }
    
    var fromCurrency: String = "BTC"
    { didSet { fromCurrencyDidChangeHandler?(fromCurrency) } }
    
    var toCurrency: String = "USD"
    { didSet { toCurrencyDidChangeHandler?(toCurrency)} }
    
    var price: Double = 0.0
    

}

