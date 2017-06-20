//
//  BlueNavigationBarViewController.swift
//  eMiner
//
//  Created by Issarapong Poesua on 6/14/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import Material
import GoogleMobileAds

class BlueNavigationBarViewController: UIViewController, GADBannerViewDelegate
{
    
    open let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
    private let bannerView = GADBannerView(adSize: kGADAdSizeBanner)
    
    open var showAdsWhileDeveloping = true
    open var showAds = true
    open var devices: [Any] = [kGADSimulatorID, "b4a8f9d85e3c256698a9768737785995"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Colors.grayBackground
        self.navigationController?
            .navigationBar
            .barTintColor = Color.blue.darken4 // bar oclor
        self.navigationController?
            .navigationBar
            .barStyle = .blackTranslucent // white text
        self.navigationController?
            .navigationBar
            .tintColor = .white // button color
        self.navigationController?
            .navigationBar
            .isTranslucent = false
        prepareBanner()
        
    }
    
    func prepareBanner()
    {
        let request = GADRequest()
        
        if (showAdsWhileDeveloping == true)
        {
            request.testDevices = devices
        }
        bannerView.adUnitID = "ca-app-pub-4131462780297434/9228958504"
        bannerView.rootViewController = self
        bannerView.delegate = self
        bannerView.load(request)
        
        self.view.addSubview(bannerView)
        self.bannerView.zPosition = 1
        
    }
    func startActivityIndicator()
    {
        actInd.frame = CGRect(x: view.center.x,
                              y: view.center.y,
                              width: 80,
                              height: 80)
        actInd.center = self.view.center
        actInd.center.y -= 64
        actInd.hidesWhenStopped = true
        actInd.activityIndicatorViewStyle = .whiteLarge
        actInd.layer.cornerRadius = 10
        actInd.backgroundColor = .black
        actInd.alpha = 0.7
        self.view.addSubview(actInd)
        actInd.startAnimating()
    }
    func stopActivityIndicator()
    {
        actInd.stopAnimating()
    }
    
    func showAlert(title: String, message: String, button: String, completion: (()->())? = nil )
    {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: button,
                                      style: .default,
                                      handler: { _ in completion?() }))
        self.present(alert,
                     animated: true,
                     completion: nil)
    }
    func delayFor(second: Int, then: (()->())? )
    {
        let when = DispatchTime.now() + .seconds(second)
        DispatchQueue.main.asyncAfter(deadline: when) { then?() }
        
    }
    override func updateViewConstraints()
    {
        var offset:CGFloat = 0.0
        if (self.tabBarController != nil)
        {
            offset = CGFloat((self.tabBarController?.tabBar.height)! * -1)
        }


            bannerView.snp.makeConstraints(){
                $0.width.equalTo(self.view)
                $0.height.equalTo(50)
                $0.bottom.equalTo(self.view).offset(offset)
                $0.centerX.equalTo(self.view)
            }
            
        
        super.updateViewConstraints()
    
    }
    
}
