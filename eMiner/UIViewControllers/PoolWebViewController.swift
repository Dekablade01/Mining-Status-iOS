//
//  PoolWebViewController.swift
//  eMiner
//
//  Created by Issarapong Poesua on 6/6/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class PoolWebViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    var urlString: String = "" { didSet { webView.loadRequest(urlRequest)} }
    
    var urlRequest: URLRequest { return URLRequest(url: URL(string: urlString + service.address)!) }
    
    @IBOutlet weak var toolBar: UIToolbar!
    
    var service: ServiceModel!
    { didSet {
        RemoteFactory
            .remoteFactory
            .remotePoolURL
            .getURL(pool: service.poolname) { print("url", $0); self.urlString = $0 }
        self.title = service.poolname + " - " + service.currency

        }
    }
    @IBAction func didPressOnBackButton(_ sender: Any)
    {
        webView.goBack()
    }
    
    @IBAction func didPressOnReloadButton(_ sender: Any)
    {
        webView.loadRequest(urlRequest)
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, toolBar.bounds.height, 0)
    }
    
    
}


extension PoolWebViewController : UIWebViewDelegate
{
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return false
        
    }
}
