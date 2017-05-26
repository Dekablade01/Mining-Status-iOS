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
    
    var miningDashBoardResponse = MiningDashBoardResponse()
    var didFinishLoadedHandler: (()->())?
    var contentArray: [CellContentModel] = []
    
    func loadData ()
    {
        RemoteFactory
            .remoteFactory
            .remoteMiningDashBoard
            .loadDetail(){
                self.miningDashBoardResponse = $0
                self.didFinishLoadedHandler?()
                self.addContentsToArray()
        }
    }
    
    func addContentToArray (_ name: String, _ value: String)
    {
        if (value != "")
        {
            let content = CellContentModel(name: name, value: value)
            contentArray.append(content)
        }
    }
    
    func addContentsToArray() {
        addContentToArray(address, miningDashBoardResponse.address)
        addContentToArray(numberOfWorkers, String(miningDashBoardResponse.numberOfRunningWorkers))
        addContentToArray(currentHashRate, String(miningDashBoardResponse.currentRashRate))
        addContentToArray(averageHashRate, String(miningDashBoardResponse.averageHashRate))
        addContentToArray(unpaidBalance, String(miningDashBoardResponse.unpaidBalance))
        addContentToArray(unpaidBalanceInBTC, String(miningDashBoardResponse.unpaidBalanceInBTC))
        addContentToArray(unpaidBalanceInOther, String(miningDashBoardResponse.unpaidBalanceInOther))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return contentArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? DashboardCollectionViewCell
            else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        }
        
        cell.contentValue = contentArray[indexPath.item].cellValue
        cell.heading = contentArray[indexPath.item].cellHeadingName
        return cell
    }

}

extension MiningDashboardCollectionViewDataSource
{
    var address:String { return "Address" }
    var numberOfWorkers:String { return "Running Workers" }
    var currentHashRate:String { return "HashRate" }
    var averageHashRate:String { return "Avg HashRate" }
    var unpaidBalance:String { return "Unpaid Balance" }
    var unpaidBalanceInBTC:String { return "Unpaid In BTC" }
    var unpaidBalanceInOther:String { return "Unpaid In Other" }
}
