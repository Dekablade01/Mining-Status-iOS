//
//  BlueNavigationBarViewController.swift
//  eMiner
//
//  Created by Issarapong Poesua on 6/14/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import Material

class BlueNavigationBarViewController: UIViewController
{

    let actInd: UIActivityIndicatorView = UIActivityIndicatorView()

    
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



}
