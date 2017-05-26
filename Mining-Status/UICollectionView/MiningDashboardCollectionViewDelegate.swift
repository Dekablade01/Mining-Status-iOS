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


    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width = collectionView.bounds.width
        let height = width/3 * (2/3)

        if (indexPath.item == 0) // 1:1
        {
            return CGSize(width: width, height: height)
        }
        else if (indexPath.item == 1 || indexPath.item == 2 || indexPath.item == 3) // 1:3
        {
            return CGSize(width: (width/3) - 10, height: height)
        }
        else if (indexPath.item == 4 || indexPath.item == 5 || indexPath.item == 6) // 1:4
        {
            return CGSize(width: (width/3) - 10, height: height)
        }
        else { return CGSize(width: 0, height: 0) }
        
    }
    

}
