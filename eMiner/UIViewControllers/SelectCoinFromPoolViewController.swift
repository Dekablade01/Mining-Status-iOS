//
//  SelectCoinFromPoolViewController.swift
//  eMiner
//
//  Created by Issarapong Poesua on 5/27/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class SelectCoinFromPoolViewController: BlueNavigationBarViewController {

    let dataSource = CurrencyListTableViewDataSource()
    
    var selectedPool: PoolModel! {
        set { dataSource.selectedPool = newValue }
        get { return dataSource.selectedPool }
    }
    var selectedCoin: String = ""
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        initialTableView(tableView)
    }
    func initialTableView(_ tableView: UITableView)
    {
        dataSource.reloadDataHandler = { tableView.reloadData() }
        
        tableView.dataSource = dataSource
        tableView.delegate = self 
    }
    
}

extension SelectCoinFromPoolViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        let currency = selectedPool.currencies[indexPath.item]

        print(currency)
        
        AddServiceSingleton.sharedInstance.serviceModel.currency = currency
    }
}
