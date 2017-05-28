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
    
    var pools: [PoolModel] { return SingleonPools.singletonPools.pools }
    
    func loadData()
    {
        RemoteFactory
            .remoteFactory
            .remoteService
            .loadService(){ SingleonPools.singletonPools.pools = $0; self.didFinishLoadedHandler?() }
            
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pools.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                       for: indexPath)
        
        cell.textLabel?.text = pools[indexPath.item].name
        var detail = ""
        
        for currency in pools[indexPath.item].currencies
        {
            detail += "\(currency) "
        }
        cell.detailTextLabel?.text = detail
        return cell
    }
    
}
