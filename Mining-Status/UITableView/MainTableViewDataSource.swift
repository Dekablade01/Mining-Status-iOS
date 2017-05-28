//
//  MainTableViewDataSource.swift
//  Mining-Status
//
//  Created by Issarapong Poesua on 5/25/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import RealmSwift
class MainTableViewDataSource: NSObject, UITableViewDataSource
{
    var didFinishLoadedHandler: (()->())?
    
    var services: [ServiceModel] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return services.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let service = services[indexPath.item]

        cell.textLabel?.text = service.poolname
        cell.detailTextLabel?.text = service.currency
        return cell
    }
    func loadData()
    {
        services.removeAll()
        let realm = try! Realm()
        let result = realm.objects(ServiceModel.self)
        
        for service in result
        {
            services.append(service)
        }
        didFinishLoadedHandler?()
    }

}
