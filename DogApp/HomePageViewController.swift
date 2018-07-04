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
    override func viewDidLoad() {
        super.viewDidLoad()
        txtName.text = name
        txtHeroID.text = heroID
        txtTaiKhoan.text = tien
        txtDiaChi.text = diachi
        
        let url:URL = URL(string: linkima)!
        print(url)
        do{
            let dulieu:Data = try Data(contentsOf: url)
            imaAvata.image = UIImage(data: dulieu)
        }
        catch{
            
        }
        
    }
    @IBAction func btnDangco(_ sender: Any) {
        let googleMap = self.storyboard?.instantiateViewController(withIdentifier: "googlemap")
        self.present(googleMap!, animated: true, completion: nil)
    }
    

    

}
