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
    
    var collectionView = UICollectionView(frame: CGRect.zero,
                                               collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
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
                $0.width.equalTo(view).inset(5)
                $0.centerX.equalTo(view)
                
            }
            isAddedConstraint = true
        }
        super.updateViewConstraints()
    }
    func initialCollectionView (_ collectionView: UICollectionView)
    {
        collectionView.register(DashboardCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = .white
        collectionView.delegate = delegate
        
        dataSource.loadData()
        dataSource.didFinishLoadedHandler = { collectionView.reloadData() }
        collectionView.dataSource = dataSource
        
    }




}
