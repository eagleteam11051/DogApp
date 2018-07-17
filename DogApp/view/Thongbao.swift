//
//  Thongbao.swift
//  DogApp
//
//  Created by Admin on 7/15/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import Alamofire
class Thongbao: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    func showAlert1(msg:String,view:UIViewController){
        let alertController = UIAlertController(title: "Thông Báo", message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            UIAlertAction in
            NSLog("OK Pressed")
            self.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(okAction)
        view.present(alertController, animated: true, completion: nil)
    }
    
    @IBOutlet weak var TableVi: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Thongbaocell", for: indexPath) as! Thongbaocell
        cell.lblThongbao.text = data[indexPath.row].message
        cell.lblThoigian.text = data[indexPath.row].created_time
        
        return cell
    }
    @IBAction func btnBack(_ sender: Any) {
        let jobWaiting = self.storyboard?.instantiateViewController(withIdentifier: "homepage")
        self.present(jobWaiting!, animated: true, completion: nil)
    }

    @IBAction func btnNextPage(_ sender: Any) {
        soTrang = soTrang+10
        print(soTrang)
        loadWorking()
    }

    @IBAction func btnBackPage(_ sender: Any) {
        if(soTrang == 0){
            print("ve mo r" )
            loadWorking()
        }else{
            print(soTrang)
            soTrang = soTrang - 10
            print(soTrang)
            loadWorking()
        }
    }
    
    var order_id = "0"
    var data:[ThongBaoObj] = []
    var mode = 1
    var update = false
    func loadWorking() {
        let headers: HTTPHeaders = [
            "X-API-KEY": "\(tokenlogin)",
            "Accept": "application/json"
        ]
        Alamofire.request("http://shipx.vn/api/index.php/VinterGetMessages/?hero_id=\(heroID)&start=\(soTrang)",headers: headers).responseJSON {(response) in
            
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
                        let order = try JSONDecoder().decode(ThongBaoObj.self, from: jsonString.data(using: .utf8)!)
                        self.data.append(order)
                    }catch let e{
                        print("error",e)
                    }
                    print(self.data.count)
                    print("===========================================")
                }
                //
                DispatchQueue.main.async {
                    self.TableVi.reloadData()
                }
            }
            //
            if(Status == "error"){
                soTrang = soTrang-10
                showAlert(msg: "Đã hết thông báo", view: self)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWorking()
        
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
