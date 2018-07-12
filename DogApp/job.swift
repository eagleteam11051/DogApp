//
//  job.swift
//  DogApp
//
//  Created by Admin on 7/9/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class job: UIViewController {

    @IBOutlet weak var lbljob: UILabel!
    @IBAction func btnShip(_ sender: Any) {
        let jobTable = self.storyboard?.instantiateViewController(withIdentifier: "jobtable")
        self.present(jobTable!, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
