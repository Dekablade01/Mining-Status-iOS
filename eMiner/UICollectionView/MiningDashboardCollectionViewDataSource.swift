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
    
    func loadData ()
    {
        let expectCurrency = UserDefaults.standard.string(forKey: "currencyCode") ?? "USD"
        
        RemoteFactory
            .remoteFactory
            .remoteMiningDashBoard
            .loadDetail(poolname: service.poolname,
                        address: service.address,
                        expectedCurrency: expectCurrency){
                            self.contents.removeAll()
                            self.contents = $0
                            if (self.service.poolname != "NiceHash")
                            {
                                self.didFinishLoadedHandler?()
                            }
                            else
                            {
                                RemoteFactory
                                    .remoteFactory
                                    .remoteNiceHash
                                    .didFinishLoadingPayoutHandler = {
                                        var payoutDate = ""
                                        if ( $0 == "N/A")
                                        {
                                            payoutDate = $0
                                            self.contents.append(CellContentModel(name: "Payout Date",
                                                                                  value: payoutDate))
                                        }
                                        else if($0 == "")
                                        {
                                            
                                        }
                                        else
                                        {
                                            payoutDate = $0.substring(to: $0.index($0.startIndex,
                                                                                   offsetBy: 10))
                                            self.contents.append(CellContentModel(name: "Payout Date",
                                                                                  value: payoutDate))
                                        }
                                        
                                        
                                        self.didFinishLoadedHandler?()
                                        
                                }
                                
                                RemoteFactory
                                    .remoteFactory
                                    .remoteNiceHash
                                    .getPayoutDate(address: self.service.address)
                                
                                
                            }
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return contents.count + 1
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

