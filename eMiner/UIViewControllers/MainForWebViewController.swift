//
//  MainForWebViewController.swift
//  eMiner
//
//  Created by Issarapong Poesua on 6/6/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//


import UIKit
import GoogleMobileAds
class MainForWebViewController: BlueNavigationBarViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var openWebSegueIdentifier: String { return "OpenWeb" }
    var adsUnit = "ca-app-pub-4131462780297434/7553748902"
    var interstitial: GADInterstitial!
    var dataSource = MainTableViewDataSource()
    
    var selectedServiceModel: ServiceModel? = nil {
        didSet { performSegue(withIdentifier: openWebSegueIdentifier, sender: self); selectedServiceModel = nil  }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialTableView()
    }
    
    func initialTableView ()
    {
        dataSource.didFinishLoadedHandler = {
            self.tableView.reloadData()
        }
        dataSource.needToFilter = false
        
        tableView.dataSource = dataSource
        tableView.delegate = self
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        dataSource.loadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == openWebSegueIdentifier && selectedServiceModel != nil)
        {
            let viewController = segue.destination as? PoolWebViewController
            
            viewController?.didPopViewControllerHandler = {
                self.randomToShowAds()
            }
            viewController?.service = selectedServiceModel!
            
        }
    }
    func prepareAds()
    {
        interstitial = GADInterstitial(adUnitID: adsUnit)
        
        let request = GADRequest()
        if(showAdsWhileDeveloping == true)
        {
            request.testDevices = devices
            
        }
        
        
        interstitial.load(request)
    }
    
    func showFullScreenAds() {
        
        if interstitial.isReady
        {
            interstitial.present(fromRootViewController: self)
        } else
        {
            print("Ad wasn't ready" )
        }
        
    }
    
    func randomToShowAds()
    {
        let diceRoll = Int(arc4random_uniform(3)) // 0, 1, 2
        
        if (diceRoll > 0)
        {
            showFullScreenAds()
        }
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if (identifier == openWebSegueIdentifier)
        {
            if selectedServiceModel == nil
            {
                return false
            }
            else
            {
                return true
            }
        }
        else
        {
            return true
        }
    }
}

extension MainForWebViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        selectedServiceModel = dataSource.services[indexPath.item]
    }
}

