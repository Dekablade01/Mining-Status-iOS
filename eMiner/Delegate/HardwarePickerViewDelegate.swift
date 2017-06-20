//
//  HardwarePickerViewDelegate.swift
//  eMiner
//
//  Created by Issarapong Poesua on 6/19/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import PickerView
class HardwarePickerViewDelegate: PickerViewDelegate
{
    var hardwares: [HardwareModel]
    { return RemoteFactory.remoteFactory.remoteHardware.hardwares }

    
    var didSelectHandler : ((HardwareModel)->())?
    var selectedFontSize: CGFloat { return 20 }
    var deSelectedFontSize: CGFloat { return 10 }
    
    func pickerView(_ pickerView: PickerView, didSelectRow row: Int, index: Int)
    {
        didSelectHandler?(hardwares[index])
        
    }
    func pickerViewHeightForRows(_ pickerView: PickerView) -> CGFloat {
        return 40
    }
    
    
    func pickerView(_ pickerView: PickerView, styleForLabel label: UILabel, highlighted: Bool) {
        label.textAlignment = .center
        if #available(iOS 8.2, *)
        {
            if (highlighted)
            {
                label.font = UIFont.systemFont(ofSize: selectedFontSize,
                                               weight: UIFontWeightLight)
            } else {
                label.font = UIFont.systemFont(ofSize: deSelectedFontSize,
                                               weight: UIFontWeightLight)
            }
        }
        else
        {
            if (highlighted) {
                label.font = UIFont(name: "HelveticaNeue-Light",
                                    size: deSelectedFontSize)
            } else {
                label.font = UIFont(name: "HelveticaNeue-Light",
                                    size: selectedFontSize)
            }
        }
        
        if (highlighted)
        {
            label.textColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1)
        } else {
            label.textColor = UIColor(red: 161.0/255.0,
                                      green: 161.0/255.0,
                                      blue: 161.0/255.0,
                                      alpha: 1.0)
        }
    }}
