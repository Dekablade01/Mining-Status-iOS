//
//  SelectCoinFromPoolViewController.swift
//  eMiner
//
//  Created by Issarapong Poesua on 5/27/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class SelectCoinFromPoolViewController: UIViewController {

    let dataSource = CurrencyListTableViewDataSource()
    
    var selectedPool: PoolModel! {
        set { dataSource.selectedPool = newValue }
        get { return dataSource.selectedPool! }
    }
    
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
    }
}
