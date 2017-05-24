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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.loadData()
        initialTableView()
    }

    func initialTableView ()
    {
        dataSource.didFinishLoadedHandler = {
            self.tableView.reloadData()
        }
        tableView.dataSource = dataSource
        
    }

}

extension MainViewController: UITableViewDelegate
{
    
}
