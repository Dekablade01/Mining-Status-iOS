//
//  MainForWebViewController.swift
//  eMiner
//
//  Created by Issarapong Poesua on 6/6/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//


import UIKit

class MainForWebViewController: BlueNavigationBarViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var openWebSegueIdentifier: String { return "OpenWeb" }
    
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
            
            viewController?.service = selectedServiceModel!
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

