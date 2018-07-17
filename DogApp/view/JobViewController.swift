//
//  JobViewController.swift
//  DogApp
//
//  Created by Admin on 7/10/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import Alamofire
class JobViewController: UIViewController {

    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var txtDiemNhan: UILabel!
    @IBOutlet weak var txtDiemGiao: UILabel!
    @IBOutlet weak var txtKhoangCach: UILabel!
    
    var data:[Order]?
    var indexPage = 0
    @IBOutlet weak var navi: UINavigationItem!
    @IBAction func back(_ sender: Any) {
        indexPage = indexPage - 1
        if(indexPage<0){
            indexPage = (data?.count)! - 1
        }
        updateData()
    }
    @IBAction func next(_ sender: Any) {
        indexPage = indexPage + 1
        if(indexPage>=(data?.count)!){
            indexPage = 0
        }
        updateData()
    }
    
    func updateData(){
        txtDiemNhan.text = data![indexPage].pickup?.address
        txtDiemGiao.text = data![indexPage].dropoff?.address
        txtKhoangCach.text = "Khoảng cách: \((data![indexPage].distance)!)Km"
        let count:Int = (data?.count)!
        navi.title = "\(indexPage+1)/\(count)"
        MaDon = data![indexPage].order_id!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
        
    }
    func showAlert1(msg:String,view:UIViewController){
        // Create the alert controller
        let alertController = UIAlertController(title: "Thông Báo", message: msg, preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            UIAlertAction in
            NSLog("OK Pressed")
//            let googleMap = self.storyboard?.instantiateViewController(withIdentifier: "googlemap")
//            self.present(googleMap!, animated: true, completion: nil)
            self.dismiss(animated: true, completion: nil)
        }
        
        // Add the actions
        alertController.addAction(okAction)
        // Present the controller
        view.present(alertController, animated: true, completion: nil)
    }
    @IBAction func btnNhanViec(_ sender: UIButton) {
//        let googleMap = self.storyboard?.instantiateViewController(withIdentifier: "googlemap")
//        self.present(googleMap!, animated: true, completion: nil)
        let time = timePicker.date
        let gio = Calendar.current.component(.hour, from: time)
        let phut = Calendar.current.component(.minute, from: time)
        print("gio:\(gio):\(phut)")
        //
        let headers: HTTPHeaders = [
            "X-API-KEY": "\(tokenlogin)",
            "Accept": "application/json"
        ]
        Alamofire.request("http://shipx.vn/api/index.php/VinterAcceptOrder/?order_id=\(MaDon)&hero_id=\(heroID)&res_time=\(gio):\(phut)",headers: headers).responseJSON {(response) in
            let Value = response.result.value as! NSDictionary
            print(Value)
            print(MaDon)
            //
            let Status = Value["status"] as! String
            if(Status == "success"){
                self.showAlert1(msg: "Đã đặt lịch thành công", view: self)
            }else{
                self.showAlert1(msg: "Lỗi, Bạn chưa thể đặt lịch", view: self)
            }
            
        }
    }
    @IBAction func btnTuChoi(_ sender: UIButton) {
        //http://shipx.vn/api/index.php/VinterRemoveOrder/?order_id=567&hero_id=16
        let headers: HTTPHeaders = [
            "X-API-KEY": "\(tokenlogin)",
            "Accept": "application/json"
        ]
        Alamofire.request("http://shipx.vn/api/index.php/VinterRemoveOrder/?order_id=\(MaDon)&hero_id=\(heroID)",headers: headers).responseJSON {(response) in
            let Value = response.result.value as! NSDictionary
            print(Value)
            print(MaDon)
            //
            let Status = Value["status"] as! String
            if(Status == "success"){
                self.showAlert1(msg: "Huỷ đơn hàng thành công", view: self)
            }else{
                self.showAlert1(msg: "Lỗi, báo lại bộ phận kỹ thuật", view: self)
            }
            
        }
//        let googleMap = self.storyboard?.instantiateViewController(withIdentifier: "googlemap")
//        self.present(googleMap!, animated: true, completion: nil)
    }
}
