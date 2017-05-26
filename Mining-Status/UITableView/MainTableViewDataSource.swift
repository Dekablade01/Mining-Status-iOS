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
    
    var serviceList = ServiceListResponse()
    func loadData()
    {
        RemoteFactory
            .remoteFactory
            .remoteService
            .loadService(){ self.serviceList = $0; self.didFinishLoadedHandler?() }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return serviceList.items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let serviceName = serviceList.items[indexPath.item]
        cell.textLabel?.text = serviceName
        
        return cell
    }

}
