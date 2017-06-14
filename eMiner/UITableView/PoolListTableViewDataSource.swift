//
//  PoolListTableViewDataSource.swift
//  eMiner
//
//  Created by Issarapong Poesua on 5/27/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class PoolListTableViewDataSource: NSObject, UITableViewDataSource
{
    var didFinishLoadedHandler : (()->())?
    
    var pools: [PoolModel] { return SingleonPools.singletonPools.getPools() }
    
    func loadData()
    {
        didFinishLoadedHandler?()
            
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pools.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                       for: indexPath)
    
        var label = ""
        if (pools[indexPath.item].name == Pool.etherMine || pools[indexPath.item].name == Pool.flyPool)
        {
            label = " (WebView Only)"
        }
        
        cell.textLabel?.text = pools[indexPath.item].name + label
        var detail = ""
        
        for currency in pools[indexPath.item].currencies
        {
            detail += "\(currency) "
        }
        cell.detailTextLabel?.text = detail
        return cell
    }
    
}
