//
//  HomePageViewController.swift
//  DogApp
//
//  Created by Admin on 7/3/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import Alamofire
class HomePageViewController: UIViewController {
    var finalToken: String?
    @IBOutlet weak var txtName: UILabel!
    @IBOutlet weak var txtHeroID: UILabel!
    @IBOutlet weak var txtTaiKhoan: UILabel!
    @IBOutlet weak var txtDiaChi: UILabel!
    @IBOutlet weak var imaAvata: UIImageView!
        @IBOutlet weak var tnumber1: UILabel!
        @IBOutlet weak var tnumber2: UILabel!
        @IBOutlet weak var tnumber3: UILabel!
        @IBOutlet weak var tnumber4: UILabel!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!

    func setOnClickListener(){
        view1.isUserInteractionEnabled = true
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(timviec(tapGestureRecognizer:)))
        view1.addGestureRecognizer(tap1)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(choduyet(tapGestureRecognizer:)))
        view2.addGestureRecognizer(tap2)
        
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(danglam(tapGestureRecognizer:)))
        view3.addGestureRecognizer(tap3)
        
        let tap4 = UITapGestureRecognizer(target: self, action: #selector(dalam(tapGestureRecognizer:)))
        view4.addGestureRecognizer(tap4)
    }
    @objc func timviec(tapGestureRecognizer: UITapGestureRecognizer){
        let googleMap = self.storyboard?.instantiateViewController(withIdentifier: "googlemap")
        self.present(googleMap!, animated: true, completion: nil)
    }
    @objc func choduyet(tapGestureRecognizer: UITapGestureRecognizer){
        let jobWaiting = self.storyboard?.instantiateViewController(withIdentifier: "job")
        self.present(jobWaiting!, animated: true, completion: nil)
    }
    @objc func danglam(tapGestureRecognizer: UITapGestureRecognizer){
        let JobWorking = self.storyboard?.instantiateViewController(withIdentifier: "jobworking")
        self.present(JobWorking!, animated: true, completion: nil)
    }
    @objc func dalam(tapGestureRecognizer: UITapGestureRecognizer){
        let History = self.storyboard?.instantiateViewController(withIdentifier: "History")
        self.present(History!, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtName.text = name
        txtHeroID.text = heroID
        txtTaiKhoan.text = tien
        txtDiaChi.text = diachi
        print(linkima)
        let url:URL = URL(string: linkima)!
        print(url)
        do{
            let dulieu:Data = try Data(contentsOf: url)
            imaAvata.image = UIImage(data: dulieu)
        }
        catch{
            
        }
        
        setOnClickListener()
    }
    
    
}
