//
//  job2.swift
//  DogApp
//
//  Created by Admin on 7/13/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class job2: UIViewController {

    @IBOutlet weak var lbljob: UILabel!
//    @IBAction func btnShip(_ sender: Any) {
//        let jobTable = self.storyboard?.instantiateViewController(withIdentifier: "jobtable2")
//        self.present(jobTable!, animated: true, completion: nil)
//    }
    
    @IBOutlet weak var viewGiaoHangNhanh: UIView!
    
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setOnClickListener()
        // Do any additional setup after loading the view.
    }
    
    func setOnClickListener(){
        viewGiaoHangNhanh.isUserInteractionEnabled = true
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(giaohangnhanh(tapGestureRecognizer:)))
        viewGiaoHangNhanh.addGestureRecognizer(tap1)
    }
    
    @objc func giaohangnhanh(tapGestureRecognizer: UITapGestureRecognizer){
        let jobTable = self.storyboard?.instantiateViewController(withIdentifier: "jobtable2")
        self.present(jobTable!, animated: true, completion: nil)
    }

}
