//
//  UINavigationController+didPopViewController.swift
//  eMiner
//
//  Created by Issarapong Poesua on 6/20/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import Foundation
import UIKit
extension UINavigationController {
    func popViewControllerWithHandler(completion: @escaping ()->()) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.popViewController(animated: true)
        CATransaction.commit()
    }
    func pushViewController(viewController: UIViewController, completion: @escaping ()->()) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.pushViewController(viewController, animated: true)
        CATransaction.commit()
    }
}
