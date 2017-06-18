//
//  MiningDashboardCollectionViewDataSource.swift
//  Mining-Status
//
//  Created by Issarapong Poesua on 5/25/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MiningDashboardCollectionViewDataSource: NSObject, UICollectionViewDataSource
{
    
    var contents: [CellContentModel] = []
    var didFinishLoadedHandler: ( () -> Void )?
    var service: ServiceModel! { didSet { startLoadingHandler?() } }
    var errorHandler: ((Error)->())?

    var startLoadingHandler: (()->())?
    var disposeBag = DisposeBag()
    
    func loadData ()
    {
        if (service.poolname == Pool.niceHash)
        {
            RemoteFactory.remoteFactory.remoteNiceHash.clearValue()
            
            RemoteFactory
                .remoteFactory
                .remoteNiceHash
                .getNicehashDetail(address: service.address)
                .subscribe(onNext: { self.contents = $0 },
                           onError: { self.errorHandler?($0)  },
                           onCompleted: { self.didFinishLoadedHandler?() } )
                .addDisposableTo(disposeBag)

        }
        else if (service.poolname == Pool.nanoPool)
        {
            
            RemoteFactory
                .remoteFactory
                .remoteNanoPool
                .getNanoPool(address: service.address,
                             coin: service.currency)
                .subscribe(onNext: { self.contents = $0 },
                           onError: { self.errorHandler?($0) },
                           onCompleted: { self.didFinishLoadedHandler?() } )
                .addDisposableTo(disposeBag)
        }
        else if(service.poolname == Pool.etherMine || service.poolname == Pool.flyPool)
        {

            
            
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return contents.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
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

