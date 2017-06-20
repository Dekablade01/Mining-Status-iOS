//
//  Double+roundTo.swift
//  eMiner
//
//  Created by Issarapong Poesua on 6/11/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import Foundation

extension Double {
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
