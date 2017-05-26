//
//  MiningDashboardViewController.swift
//  Mining-Status
//
//  Created by Issarapong Poesua on 5/24/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import SnapKit

class MiningDashboardViewController: UIViewController
{
    let delegate = MiningDashboardCollectionViewDelegate()
    let dataSource = MiningDashboardCollectionViewDataSource()
    
    var isAddedConstraint = false
    let refresher = UIRefreshControl()

    
    var collectionView = UICollectionView(frame: CGRect.zero,
                                               collectionViewLayout: UICollectionViewFlowLayout())
    var collectionViewLayout = UICollectionViewFlowLayout()
    
    override func viewDidLoad()
    
    {
        super.viewDidLoad()
        loadData()
        initialCollectionView(collectionView)
        self.view.addSubview(collectionView)
        self.view.setNeedsUpdateConstraints()
        
    }
    override func updateViewConstraints() {
        
        if (isAddedConstraint == false)
        {
            collectionView.snp.makeConstraints(){
                $0.centerY.equalTo(view)
                $0.height.equalTo(view)
                $0.width.equalTo(view).inset(15)
                $0.centerX.equalTo(view)
                
            }
            isAddedConstraint = true
        }
        super.updateViewConstraints()
    }
    func loadData(){
        dataSource.loadData()
        stopRefresher()
    }
    
    func stopRefresher()
    {
        refresher.endRefreshing()
    }
    func initialCollectionView (_ collectionView: UICollectionView)
    {
        collectionView.alwaysBounceVertical = true
        refresher.addTarget(self, action: #selector(self.loadData), for: .valueChanged)
        collectionView.addSubview(refresher)
        collectionView.alpha = 0
        collectionView.collectionViewLayout = collectionViewLayout
        
        collectionView.register(DashboardCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = .white
        collectionView.delegate = delegate
        
        
        dataSource.didFinishLoadedHandler = {
            collectionView.reloadData()
            
            UIView.animate(withDuration: 0.4)
            {
                collectionView.alpha = 1
            }
            
        }
        collectionView.dataSource = dataSource
        
    }




}
