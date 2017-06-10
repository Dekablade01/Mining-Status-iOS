//
//  MiningDashboardCollectionViewDataSource.swift
//  Mining-Status
//
//  Created by Issarapong Poesua on 5/25/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class MiningDashboardCollectionViewDataSource: NSObject, UICollectionViewDataSource
{
    
    var contents: [CellContentModel] = []
    var didFinishLoadedHandler: (()->())?
    var service: ServiceModel! { didSet { loadData() } }
    var error:String? //{ didSet { print("error : ", error!) } }
    
    func loadData ()
    {
        if (service.poolname == "NiceHash")
        {
            RemoteFactory
                .remoteFactory
                .remoteNiceHash
                .getNicehashDetail(address: service.address) { contents in
                    self.contents = contents.0
                    self.error = contents.1
                    self.didFinishLoadedHandler?() }
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return contents.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? DashboardCollectionViewCell
            else {
                return collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        }
        if( indexPath.item != contents.count)
        {
            cell.contentValue = contents[indexPath.item].value
            cell.heading = contents[indexPath.item].name
        }
        else if ( indexPath.item == contents.count && indexPath.item != 0 )
        {
            cell.alpha = 0
        }
        
        return cell
    }
    
}

