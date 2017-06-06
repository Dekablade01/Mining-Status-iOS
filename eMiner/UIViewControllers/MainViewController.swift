//
//  MainViewController.swift
//  Mining-Status
//
//  Created by Issarapong Poesua on 5/25/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dataSource = MainTableViewDataSource()
    
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
            
            viewController?.serviceModel = selectedServiceModel!
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
}

extension MainViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        selectedServiceModel = dataSource.services[indexPath.item]
    }
}
