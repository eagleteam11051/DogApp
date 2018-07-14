//
//  job.swift
//  DogApp
//
//  Created by Admin on 7/9/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class job: UIViewController {

    @IBOutlet weak var viewgiaohangnhanh: UIView!
    @IBAction func btnBack(_ sender: Any) {
        let homePage = self.storyboard?.instantiateViewController(withIdentifier: "homepage")
        self.present(homePage!, animated: true, completion: nil)
    }
    func setOnClickListener(){
        viewgiaohangnhanh.isUserInteractionEnabled = true
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(giaohangnhanh(tapGestureRecognizer:)))
        viewgiaohangnhanh.addGestureRecognizer(tap1)
    }
    @objc func giaohangnhanh(tapGestureRecognizer: UITapGestureRecognizer){
        let jobTable = self.storyboard?.instantiateViewController(withIdentifier: "jobtable")
        self.present(jobTable!, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setOnClickListener()
    }
}
