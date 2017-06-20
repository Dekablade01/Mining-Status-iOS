//
//  SingleonPools.swift
//  eMiner
//
//  Created by Issarapong Poesua on 5/27/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class SingleonPools: NSObject
{
    static var singletonPools = SingleonPools()
    
    private var flyPool = PoolModel(name: Pool.flyPool,
                                    currencies: [Currency.zec])
    private var nanoPool = PoolModel(name: Pool.nanoPool,
                                     currencies: [Currency.etc, Currency.eth, Currency.sia, Currency.zec])
    private var niceHash = PoolModel(name: Pool.niceHash,
                                     currencies: [Currency.btc])
    private var etherMine = PoolModel(name: Pool.etherMine,
                                      currencies: [Currency.etc, Currency.eth])
    
    private var pools: [PoolModel] = []
    
    override init() {

        pools.append(nanoPool)
        pools.append(niceHash)
        pools.append(etherMine)
        pools.append(flyPool)
    }
    
    func getPools() -> [PoolModel]
    {
        return pools
    }
    
}
