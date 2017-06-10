//
//  Array+RemoveDuplicate.swift
//  eMiner
//
//  Created by Issarapong Poesua on 6/10/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import Foundation


public extension Sequence where Iterator.Element: Hashable {
    var uniqueElements: [Iterator.Element] {
        return Array( Set(self) )
    }
}
public extension Sequence where Iterator.Element: Equatable {
    var uniqueElements: [Iterator.Element] {
        return self.reduce([]){
            uniqueElements, element in
            
            uniqueElements.contains(element)
                ? uniqueElements
                : uniqueElements + [element]
        }
    }
}
