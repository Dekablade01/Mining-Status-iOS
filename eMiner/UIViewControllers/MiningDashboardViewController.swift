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
    
    let actInd: UIActivityIndicatorView = UIActivityIndicatorView()

    override func viewDidLoad()
    
    {
        super.viewDidLoad()
        self.title = serviceModel.poolname + " - " + serviceModel.currency
        initialCollectionView(collectionView)
        
    }
    override func viewDidDisappear(_ animated: Bool)
    {
        super.viewDidDisappear(animated)
        
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
    func loadData(){
        
        if (ableToload == true)
        {
            showIndicator()
            dataSource.loadData()
            stopRefresher()
            ableToload = false
            delayFor(second: 10){
                self.ableToload = true
            }
        }
        else
        {
            showIndicator()
            stopRefresher()
            actInd.stopAnimating()
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
            
            print(self.dataSource.contents.count)
            
            if (self.dataSource.error == nil)
            {
                UIView.animate(withDuration: 0.4)
                {
                    collectionView.reloadData()
                    collectionView.alpha = 1
                }
            }
            else
            {

                self.showAlert(title: "Something went Wrong",
                               message: (self.dataSource.error)!,
                               button: "OK")
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        
       
        
        collectionView.dataSource = self.dataSource
        
    }
    
    func delayFor(second: Int, then: (()->())? )
    {
        let when = DispatchTime.now() + .seconds(second)
        DispatchQueue.main.asyncAfter(deadline: when) { then?() }
        
    }

    func showAlert(title: String, message: String, button: String)
    {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: button,
                                      style: .default,
                                      handler: nil))
        self.present(alert,
                     animated: true,
                     completion: nil)
    }



}
