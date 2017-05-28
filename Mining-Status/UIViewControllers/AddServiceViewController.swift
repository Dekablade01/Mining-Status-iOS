//
//  AddServiceViewController.swift
//  eMiner
//
//  Created by Issarapong Poesua on 5/27/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class AddServiceViewController: UIViewController
{
    @IBOutlet weak var tableView: UITableView!
    var dataSource = PoolListTableViewDataSource()
    var delegate = AddPoolTableViewDelegate()
    var pools:[PoolModel] { return SingleonPools.singletonPools.pools }
    
    var selectedPool: PoolModel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        initial(tableView: tableView)
    }
    
    func initial(tableView: UITableView)
    {
        dataSource.loadData()
        
        dataSource.didFinishLoadedHandler = { self.tableView.reloadData() }
        
        tableView.dataSource = dataSource
        tableView.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        selectedPool = nil 
    }
    @IBAction func dismissViewController(_ sender: UIBarButtonItem)
    {
        self.dismiss(animated: true,
                     completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        guard let pool = selectedPool else { return }
        if (segue.identifier == "ShowCurrenyList")
        {
            guard let  viewController = segue.destination as? SelectCoinFromPoolViewController
                else { return }
                viewController.selectedPool = pool
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool
    {
        guard (selectedPool != nil) else { return false }

        return true
    }
    
}
extension AddServiceViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        self.selectedPool = self.pools[indexPath.item]
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.performSegue(withIdentifier: "ShowCurrenyList", sender: self)
    }

}
