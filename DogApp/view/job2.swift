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
        let homePage = self.storyboard?.instantiateViewController(withIdentifier: "homepage")
        self.present(homePage!, animated: true, completion: nil)
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
