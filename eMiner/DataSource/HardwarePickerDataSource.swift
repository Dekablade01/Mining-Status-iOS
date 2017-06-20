//
//  HardwarePickerDataSource.swift
//  eMiner
//
//  Created by Issarapong Poesua on 6/19/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import PickerView

class HardwarePickerDataSource: PickerViewDataSource
{
    
    private var hardwares: [HardwareModel]
    { return RemoteFactory.remoteFactory.remoteHardware.hardwares }
    
    private var disposeBag = DisposeBag()
    
    var errorHandler : ((Error)->())?

    func pickerViewNumberOfRows(_ pickerView: PickerView) -> Int
    {
        return hardwares.count
    }
    func pickerView(_ pickerView: PickerView,
                    titleForRow row: Int, index: Int) -> String
    {
        return hardwares[row].name
    }


}
