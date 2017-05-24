//
//  Remote.swift
//  Mining-Status
//
//  Created by Issarapong Poesua on 5/25/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit


enum server {
    static let localhost = "http://localhost:5000/api/"
    static let heroku = "https://salty-fortress-22218.herokuapp.com/api/"
}

enum Remote {
    static let poolList = server.localhost + "pool-list"
}


