//
//  AddPoolTableViewDelegate.swift
//  eMiner
//
//  Created by Issarapong Poesua on 5/27/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class AddPoolTableViewDelegate: NSObject, UITableViewDelegate
{
    var didSelectHandler: ((IndexPath)->())?
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        didSelectHandler?(indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
