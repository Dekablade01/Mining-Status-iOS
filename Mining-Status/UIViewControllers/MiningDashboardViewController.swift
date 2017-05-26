//
//  MiningDashboardViewController.swift
//  Mining-Status
//
//  Created by Issarapong Poesua on 5/24/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class MiningDashboardViewController: UIViewController
{
    let delegate = MiningDashboardCollectionViewDelegate()
    let dataSource = MiningDashboardCollectionViewDataSource()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        initialCollectionView(collectionView)
        
    }
    func initialCollectionView (_ collectionView: UICollectionView)
    {
        collectionView.delegate = delegate
        
        dataSource.loadData()
        dataSource.didFinishLoadedHandler = { collectionView.reloadData() }
        collectionView.dataSource = dataSource
        
    }




}
