//
//  history.swift
//  DogApp
//
//  Created by Admin on 7/13/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import Alamofire
class history: UIViewController,UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historycell", for: indexPath) as! HistoryCell
        cell.lblNote.text = data[indexPath.row].note
        cell.lblTime.text = data[indexPath.row].create_time
        
        return cell
    }
    
    var order_id = "0"
    var data:[Order] = []
    var mode = 1
    var update = false


    
    func loadWorking(){
        let headers: HTTPHeaders = [
            "X-API-KEY": "\(tokenlogin)",
            "Accept": "application/json"
        ]
        Alamofire.request("http://shipx.vn/api/index.php/VinterGetOrders/?hero_id=\(heroID)&status=8&start_date=24-06-2018&end_date=02-08-2018&start=0",headers: headers).responseJSON {(response) in
            
            let Value = response.result.value as! NSDictionary
            let Status = Value["status"] as! String
            
            
            if(Status == "success"){
                let a = Status.count
                let res = Value["response"] as! [[String: Any]]
                self.data.removeAll()
                for item in res{
                    //
                    //                    self.Goi.append(item["shipping_type"] as! String)
                    //                    self.YeuCau.append(item["note"] as! String)
                    //                    self.Thoigian.append(item["create_time"] as! String)
                    //                    print(self.YeuCau)
                    //                    print(self.Goi)
                    //                    print(self.Thoigian)
                    print("===========================================")
                    //print(item.description)
                    do{
                        //                        let order = try JSONDecoder().decode(Order.self, from: NSKeyedArchiver.archivedData(withRootObject: item))
                        //                        print("order_id:",order.order_id)
                        //
                        
                        let jsonData = try? JSONSerialization.data(withJSONObject: item, options: [])
                        let jsonString:String = String(data: jsonData!, encoding: .utf8)!
                        print("jsonString:",jsonString)
                        let order = try JSONDecoder().decode(Order.self, from: jsonString.data(using: .utf8)!)
                        self.data.append(order)
                    }catch let e{
                        print("error",e)
                    }
                    print(self.data.count)
                    print("===========================================")
                }
                //
                DispatchQueue.main.async {
                    self.tablev.reloadData()
                }
            }
            
        }
    }
    
    @IBOutlet weak var tablev: UITableView!
    @IBAction func btnBack(_ sender: Any) {
        let homePage = self.storyboard?.instantiateViewController(withIdentifier: "homepage")
        self.present(homePage!, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWorking()
        // Do any additional setup after loading the view.
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
