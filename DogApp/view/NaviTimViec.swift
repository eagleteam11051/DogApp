//
//  NaviTimViec.swift
//  DogApp
//
//  Created by Admin on 7/14/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class NaviTimViec: UIViewController {
    var dele:navitimviec?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func back(_ sender: Any) {
        dele?.back()
    }
    
}
