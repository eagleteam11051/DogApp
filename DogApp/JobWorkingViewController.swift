//
//  JobWorkingViewController.swift
//  DogApp
//
//  Created by Admin on 7/12/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import Alamofire

class JobWorkingViewController: UIViewController{
    var YeuCau = [String]()
    var Thoigian = [String]()
    var Goi = [String]()
    var soCV: Int = 1
    
    @IBOutlet weak var tableview: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let headers: HTTPHeaders = [
            "X-API-KEY": "44wkgccggkgo4gccc80040s84k8cg8kscgck80c0",
            "Accept": "application/json"
        ]
        Alamofire.request("http://shipx.vn/api/index.php/VinterGetOrders/?hero_id=16&status=9&start_date=21-06-2018&end_date=30-07-2018&start=0",headers: headers).responseJSON {(response) in
            let Value = response.result.value as! NSDictionary
            let Status = Value["status"] as! String
            
            
            if(Status == "success"){
                let a = Status.count
                let res = Value["response"] as! [[String: Any]]
                self.soCV = a
                print(self.soCV)
                for item in res{
                    
                    self.Goi.append(item["shipping_type"] as! String)
                    self.YeuCau.append(item["note"] as! String)
                    self.Thoigian.append(item["create_time"] as! String)
                    print(self.YeuCau)
                    print(self.Goi)
                    print(self.Thoigian)
                    print("===========================================")
                }
                //
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                }
            }
            
        }
    }
    func tableView(_ tableView: UITableView,numberOfRowsInSection section: Int) -> Int {
        print(self.soCV)
        return soCV
    }
    
//    func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "jhgf") as! JobWorkingTableViewCell
//        cell.lblTieude.text! = Goi[indexPath.row]
//        cell.imaIcon.image = UIImage(named: "bike")
//      //  cell.lblYeucau.text = YeuCau[indexPath.row]
//        return cell
//    }
    
}
