//
//  TabBarViewController.swift
//  eMiner
//
//  Created by Issarapong Poesua on 6/17/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import Material

class TabBarViewController: UITabBarController {
    
    let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.view.backgroundColor = Colors.grayBackground
        self.navigationController?
            .navigationBar
            .barTintColor = Color.blue.darken3 // bar oclor
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
    
}
