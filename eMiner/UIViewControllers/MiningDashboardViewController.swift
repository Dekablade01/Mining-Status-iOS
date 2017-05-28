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
    
    var serviceModel: ServiceModel {
        get { return dataSource.service }
        set { dataSource.service = newValue } 
    }
    
    let actInd: UIActivityIndicatorView = UIActivityIndicatorView()

    override func viewDidLoad()
    
    {
        super.viewDidLoad()
        initialCollectionView(collectionView)
        self.view.addSubview(collectionView)
        self.view.setNeedsUpdateConstraints()
        
    }
    func showIndicator ()
    {
        actInd.frame = CGRect(x: view.center.x, y: view.center.y, width: 80, height: 80)
        actInd.center = self.view.center
        actInd.hidesWhenStopped = true
        actInd.activityIndicatorViewStyle = .whiteLarge
        actInd.layer.cornerRadius = 10
        actInd.backgroundColor = .black
        actInd.alpha = 0.7
        self.view.addSubview(actInd)
        
        actInd.startAnimating()
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
        showIndicator()
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
        collectionView.contentInset = UIEdgeInsetsMake(15, 0, 0, 0)
        collectionView.collectionViewLayout = collectionViewLayout
        
        collectionView.register(DashboardCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = .white
        collectionView.delegate = delegate
        
        
        dataSource.didFinishLoadedHandler = {
            collectionView.reloadData()
            self.actInd.stopAnimating()
            
            UIView.animate(withDuration: 0.4)
            {
                collectionView.alpha = 1
            }
        }
        collectionView.dataSource = dataSource
        
    }




}
