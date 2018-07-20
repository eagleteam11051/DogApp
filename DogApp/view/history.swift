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
        let des:String = data[indexPath.row].description ?? "null"
        let dis:String = data[indexPath.row].distance ?? "null"
        let fee:String = data[indexPath.row].fee ?? "null"
        cell.lblNote.text = "Mặt Hàng: \(des)"
        cell.lblTime.text = "Quoãng Đường:\(dis)Km"
        cell.lblsoTien.text = "Số Tiền: \(fee)đ"
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
        Alamofire.request("http://shipx.vn/api/index.php/VinterGetOrders/?hero_id=\(heroID)&status=8&start_date=24-06-2018&end_date=\(DateWorking)&start=0",headers: headers).responseJSON {(response) in
            
            let Value = response.result.value as! NSDictionary
            let Status = Value["status"] as! String
            
            
            if(Status == "success"){
                let a = Status.count
                let res = Value["response"] as! [[String: Any]]
                self.data.removeAll()
                for item in res{
                    //
                    print("===========================================")
                    do{
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
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWorking()    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
