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
        cell.detailTextLabel?.text = service.currency + " - " + service.address
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            removeData(id: services[indexPath.row].id)
            services.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
        else if editingStyle == .insert
        {
            
        }
    }
    func removeData(id: String)
    {
        let services = self.services.filter(){ $0.id == id }
        print(services.count)
        
        let realm = try! Realm()
        
        for service in services {
            try! realm.write {
                realm.delete(service)
            }
        }
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
