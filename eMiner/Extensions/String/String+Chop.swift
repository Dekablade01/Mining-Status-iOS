//
//  File.swift
//  eMiner
//
//  Created by Issarapong Poesua on 6/12/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import Foundation

extension String {
    func chopPrefix(_ count: Int = 1) -> String {
        return substring(from: index(startIndex, offsetBy: count))
    }
    
    func chopSuffix(_ count: Int = 1) -> String {
        return substring(to: index(endIndex, offsetBy: -count))
    }
}
