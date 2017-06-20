//
//  MainForDashboardViewController.swift
//  Mining-Status
//
//  Created by Issarapong Poesua on 5/25/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import Material
import GoogleMobileAds
class MainForDashboardViewController: BlueNavigationBarViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource = MainTableViewDataSource()
    
    var adsUnit = "ca-app-pub-4131462780297434/7553748902"
    var interstitial: GADInterstitial!
    
    var selectedServiceModel: ServiceModel? = nil {
        didSet { performSegue(withIdentifier: "OpenDashboard", sender: self); selectedServiceModel = nil  }
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
        
        dataSource.needToFilter = true
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
        if (segue.identifier == "OpenDashboard")
        {
            let viewController = segue.destination as? MiningDashboardViewController
            prepareAds()
            viewController?.serviceModel = selectedServiceModel!
            viewController?.didPopViewControllerHandler = {
                self.randomToShowAds()
            }
        }
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if (identifier == "OpenDashboard")
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
}

extension MainForDashboardViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        selectedServiceModel = dataSource.services[indexPath.item]
    }
}

