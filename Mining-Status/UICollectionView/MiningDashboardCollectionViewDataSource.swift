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
        self.didFinishLoadedHandler?()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return contentArray.count + 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? DashboardCollectionViewCell
            else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        }
        if( indexPath.item != contentArray.count)
        {
            cell.contentValue = contentArray[indexPath.item].cellValue
            cell.heading = contentArray[indexPath.item].cellHeadingName
        }
        
        return cell
    }

}

extension MiningDashboardCollectionViewDataSource
{
    var address:String { return "Address" }
    var numberOfWorkers:String { return "Workers" }
    var currentHashRate:String { return "HashRate" }
    var averageHashRate:String { return "Avg HashRate" }
    var unpaidBalance:String { return "Balance" }
    var unpaidBalanceInBTC:String { return "In BTC" }
    var unpaidBalanceInOther:String { return "In " + requestedCurrency }
    var requestedCurrency: String { return miningDashBoardResponse.requestedCurrency }
}
