//
//  MiningDashboardViewController.swift
//  Mining-Status
//
//  Created by Issarapong Poesua on 5/24/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import SnapKit

class MiningDashboardViewController: BlueNavigationBarViewController
{
    let delegate = MiningDashboardCollectionViewDelegate()
    let dataSource = MiningDashboardCollectionViewDataSource()
    
    var ableToload = true
    
    var isAddedConstraint = false
    let refresher = UIRefreshControl()

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var collectionViewLayout = UICollectionViewFlowLayout()
    
    var serviceModel: ServiceModel {
        get { return dataSource.service }
        set { dataSource.startLoadingHandler = { self.loadData() }
            dataSource.service = newValue }
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = Colors.grayBackground
        self.title = serviceModel.poolname + " - " + serviceModel.currency
        initialCollectionView(collectionView)
        self.view.backgroundColor = .white
        
        
        self
            .navigationController?
            .popViewControllerWithHandler(completion: { print("poped") })
    }
    override func viewDidDisappear(_ animated: Bool)
    {

        if (self.navigationController?.viewControllers.count == nil )
        {
            didPopViewControllerHandler?()
        }
    }
    
    var didPopViewControllerHandler: (()->())?

    func loadData(){
        
        if (ableToload == true)
        {
            startActivityIndicator()
            dataSource.loadData()
            stopRefresher()
            ableToload = false
            delayFor(second: 10){
                self.ableToload = true
            }
        }
        else
        {
            stopRefresher()
        }
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
        collectionView.contentInset = UIEdgeInsetsMake(7.5, 0, 0, 0)
        collectionView.collectionViewLayout = collectionViewLayout
        
        collectionView.register(DashboardCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = .white
        collectionView.delegate = delegate
    
        dataSource.didFinishLoadedHandler = {
            
            self.actInd.stopAnimating()

                UIView.animate(withDuration: 0.4)
                {
                    collectionView.reloadData()
                    collectionView.alpha = 1
                }

        }
        dataSource.errorHandler = {
            self.stopActivityIndicator()
            self.showAlert(title: "Something went wrong",
                      message: $0.localizedDescription,
                      button: "OK"){
                        self.navigationController?.popViewController(animated: true)
            }
        }
        collectionView.dataSource = self.dataSource
    }


}
