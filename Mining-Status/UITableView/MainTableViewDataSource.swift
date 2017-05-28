//
//  MainTableViewDataSource.swift
//  Mining-Status
//
//  Created by Issarapong Poesua on 5/25/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift
import RxCocoa
import AlamofireObjectMapper
class MainTableViewDataSource: NSObject, UITableViewDataSource
{
    var didFinishLoadedHandler: (()->())?
    
    var pools: [PoolModel] = []
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return pools.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let pool = pools[indexPath.item]

        cell.textLabel?.text = pool.name
        cell.detailTextLabel?.text = pool.currencies.first
        return cell
    }

}
