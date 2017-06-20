//
//  MoreViewController.swift
//  eMiner
//
//  Created by Issarapong Poesua on 6/7/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class MoreViewController: BlueNavigationBarViewController
{
    
    @IBOutlet weak var tableView: UITableView!
    let grayTextColor = #colorLiteral(red: 0.6251067519, green: 0.6256913543, blue: 0.6430284977, alpha: 1)
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        loadCurrencies()
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
    
    private func loadCurrencies()
    {
        self.view.isUserInteractionEnabled = false

        if (RemoteFactory.remoteFactory.remoteCurrencies.currencies.count == 0)
        {
            startActivityIndicator()
            _ = RemoteFactory
                .remoteFactory
                .remoteCurrencies
                .loadCurrencies()
                .subscribe(onNext: { _ in self.stopActivityIndicator() } ,
                           onError: { self.showAlert(title: "Something went wrong",
                                                     message: $0.localizedDescription,
                                                     button: "OK") { self.delayFor(second: 5, then: { self.loadCurrencies() } ) }  } ,
                           onCompleted: { self.view.isUserInteractionEnabled = true })
            
        }
        else
        {
            self.view.isUserInteractionEnabled = true
        }
        
    }

    

}

extension MoreViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if (indexPath.item == 0) {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell")
            cell?.textLabel?.text = "Calculate to"
            cell?.detailTextLabel?.text = RemoteCurrencyCalculator.toCurrency
            cell?.detailTextLabel?.textColor = grayTextColor
            return cell!
        }
        if (indexPath.item == 1)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "requestPoolCell")
            cell?.textLabel?.text = "Request more pools"
            cell?.detailTextLabel?.text = ""
            cell?.detailTextLabel?.textColor = Colors.grayTextLabel

            return cell!
        }
        if (indexPath.item == 2)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "facebookCell")
            
            cell?.textLabel?.text = "Facebook Community"
            cell?.detailTextLabel?.text = ""
            cell?.detailTextLabel?.textColor = Colors.grayTextLabel
            
            return cell!
            
        }
        if (indexPath.item == 3)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "versionCell")
            cell?.textLabel?.text = "Version"
            cell?.detailTextLabel?.text = "1.0.0"
            cell?.accessoryType = .disclosureIndicator
            cell?.detailTextLabel?.textColor = Colors.grayTextLabel

            cell?.accessoryView = UIView()
            return cell!
        }
        
        return tableView.dequeueReusableCell(withIdentifier: "facebookCell")!
    }
    func openFacebookURL ()
    {
        
        let groupID = "106803356556494"
        let url = "fb://group/?id=\(groupID)"
        
        
        if (UIApplication.shared.canOpenURL(URL(string: url)!) == true )
        {
            UIApplication.shared.openURL(URL(string: url)!)

        }
        else
        {
            let url = "https://m.facebook.com/groups/106803356556494/"
            UIApplication.shared.openURL(URL(string: url)!)

        }
        
        
        

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
        if (indexPath.item == 2)
        {
            openFacebookURL()
            
        }
    }
}

