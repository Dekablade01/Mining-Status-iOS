//
//  MainTableViewDataSource.swift
//  Mining-Status
//
//  Created by Issarapong Poesua on 5/25/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import Alamofire

class MainTableViewDataSource: NSObject, UITableViewDataSource
{
    var didFinishLoadedHandler: (()->())?
    
    var serviceList:[String] = []{
        didSet {
            didFinishLoadedHandler?()
        }
    }
    
    func loadData()
    {
        Alamofire.request(Remote.poolList).responseJSON(){ response in
   
            if let object = response.result.value as? [String: AnyObject]
            {
                let value = object["serviceList"]
                
                self.serviceList = value as! [String]

            }
            
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return serviceList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let serviceName = serviceList[indexPath.item]
        cell.textLabel?.text = serviceName
        
        return cell
    }

}
