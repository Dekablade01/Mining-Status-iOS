//
//  MiningDashboardCollectionViewDelegate.swift
//  Mining-Status
//
//  Created by Issarapong Poesua on 5/25/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class MiningDashboardCollectionViewDelegate: NSObject, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width = collectionView.bounds.width
        let height = width/3 * (2.5/3)

        if (indexPath.item == 0) // 1:1
        {
            let size = CGSize(width: width,
                              height: height)
            return size
        }
        else if (indexPath.item >= 1 && indexPath.item < 7) // 1:3
        {
            let size = CGSize(width: (width/3) - 7, height: height)
            return size
        }

        else { return CGSize(width: 0, height: 0) }
    }
    

}
