//
//  CurrencyPickerDataSource.swift
//  eMiner
//
//  Created by Issarapong Poesua on 6/15/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import PickerView
import RxSwift
import RxCocoa

class CurrencyPickerDataSource: NSObject, PickerViewDataSource {

    var currencies: [CurrencyModel]  { return RemoteFactory.remoteFactory.remoteCurrencies.currencies }
    private var disposeBag = DisposeBag()
    var errorHandler: ((Error)->())?
    var didFinishLoadingHandler: (()->())?

    
    
    func pickerViewNumberOfRows(_ pickerView: PickerView) -> Int {
        return currencies.count
    }
    func pickerView(_ pickerView: PickerView, titleForRow row: Int, index: Int) -> String {
        let name = "\(currencies[index].symbol) - \(currencies[index].name)"
        
        return name
    }
    
}
