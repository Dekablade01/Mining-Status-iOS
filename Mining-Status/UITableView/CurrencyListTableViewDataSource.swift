//
//  CurrencyListTableViewDataSource.swift
//  eMiner
//
//  Created by Issarapong Poesua on 5/27/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class CurrencyListTableViewDataSource: NSObject, UITableViewDataSource
{
    var selectedPool: PoolModel! {
        didSet
        {
            guard let pool = selectedPool
                else { print("selectedPool is nil:\(selectedPool == nil)")
                    return
            }
            print("receivedPool: \(pool.name), currencies: \(pool.currencies)")
            reloadDataHandler?()
        }
    }
    
    
    var reloadDataHandler: (()->())?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        guard let pool = self.selectedPool
            else { print("selectedPool is nil : \(self.selectedPool == nil)"); return 0 }
        
        return pool.currencies.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = selectedPool.currencies[indexPath.item]
        
        return cell
    }
}
