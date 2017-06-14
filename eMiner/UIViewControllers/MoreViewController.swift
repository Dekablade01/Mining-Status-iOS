//
//  MoreViewController.swift
//  eMiner
//
//  Created by Issarapong Poesua on 6/7/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController
{
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func openMailComposer()
    {
        let email = "dekablade01@gmail.com"
        let subject = "eMiners : I need more pool(s)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        let body = "Poolname%20%3A%20%0ACoin%20%3A%20%0A%0A%0A"
        
        let url = "mailto:" + email + "?subject=" + subject + "&body=" + body
        if let url = URL(string:url) {
            UIApplication.shared.openURL(url)
        }
    }
}

extension MoreViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if (indexPath.item == 0) {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell")
            cell?.textLabel?.text = "Convert to"
            cell?.detailTextLabel?.text = RemoteCurrencyCalculator.toCurrency
            return cell!
        }
        if (indexPath.item == 1)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "requestPoolCell")
            cell?.textLabel?.text = "Request more pools"
            cell?.detailTextLabel?.text = ""
            return cell!
        }
        if (indexPath.item == 2)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "versionCell")
            cell?.textLabel?.text = "Version"
            cell?.detailTextLabel?.text = "1.0.0"
            cell?.accessoryType = .disclosureIndicator
            cell?.accessoryView = UIView()
            return cell!
        }
        
        return tableView.dequeueReusableCell(withIdentifier: "")!
        
        
    }
}
extension MoreViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if(indexPath.item == 1)
        {
            openMailComposer()
        }
    }
}

