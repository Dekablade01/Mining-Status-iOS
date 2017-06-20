//
//  PoolURL.swift
//  eMiner
//
//  Created by Issarapong Poesua on 6/12/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class PoolURL: NSObject
{
    static func getPoolURL (poolname: String, currency: String) -> String
    {
        var url = ""
        
        switch poolname {
        case Pool.niceHash :
            url = "https://www.nicehash.com/index.jsp?utm_source=NHM&p=miners&addr="
        case Pool.nanoPool :
            switch currency {
            case Currency.etc:
                url = "https://etc.nanopool.org/account/"
            case Currency.eth:
                url = "https://eth.nanopool.org/account/"
            case Currency.pasc:
                url = "https://pasc.nanopool.org/account/"
            case Currency.sia:
                url = "https://sia.nanopool.org/account/"
            case Currency.zec:
                url = "https://zec.nanopool.org/account/"
            default:
                url = ""
            }
        case Pool.etherMine :
            switch currency {
            case Currency.etc:
                url = "https://etc.ethermine.org/miners/"
            case Currency.eth:
                url = "https://ethermine.org/miners/"
            default:
                url = ""
            }
        case Pool.flyPool:
            switch currency {
            case Currency.zec:
                url = "https://zcash.flypool.org/miners/"
            default:
                url = ""
            }
            
        default:
            url = ""
        }
        return url
    }
    
}

