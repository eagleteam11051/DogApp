//
//  Working.swift
//  DogApp
//
//  Created by Admin on 7/13/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation
import MessageUI
import SCLAlertView

class Working: UIViewController ,UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate, MFMessageComposeViewControllerDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    var a: Int = 0
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "workingcell", for: indexPath) as! WorkingCell
        cell.note.text = data[indexPath.row].description
        cell.time.text = data[indexPath.row].create_time
       a = indexPath.row
        cell.nhanhang.tag = indexPath.row
        if(data[indexPath.row].status == "5"){
            // Đã nhận
            cell.nhanhang.backgroundColor = UIColor.blue
            cell.nhanhang.setTitle("Đã Nhận", for: .normal)
         //   print("xin====================chao")
        }else{
            cell.nhanhang.addTarget(self, action: #selector(self.nhanhang(_:)), for: .touchUpInside)
        }
       
        cell.giaohang.tag = indexPath.row
        cell.giaohang.addTarget(self, action: #selector(self.giaohang(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chitietcongviec = storyboard?.instantiateViewController(withIdentifier: "chitietcongviec") as! ChiTietCongViec
        chitietcongviec.order = data[indexPath.row]
        
        self.present(chitietcongviec, animated: true, completion: nil)
    }
    
    func requestLocation(){
        if(Net.isConnectedToNetwork()){
            // Do any additional setup after loading the view, typically from a nib.
            locationManager.requestAlwaysAuthorization()
            // For use when the app is open
            //locationManager.requestWhenInUseAuthorization()
            // If location services is enabled get the users location
            if CLLocationManager.locationServicesEnabled() {
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyBest // You can change the locaiton accuary here.
                locationManager.startUpdatingLocation()
            }else{
                //khong co location
                
            }
        }else{
            let alertController = UIAlertController(title: "Thông báo", message: "Máy của bạn hiện tại không có kết nối mạng!", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
                print("you've pressed ok")
            }
            
            alertController.addAction(action1)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    //load location
    // Print out the location to the console
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:",error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            if(loadedLocation==false){
                loadedLocation=true
                
                print(location.coordinate)
                lat=location.coordinate.latitude
                lng=location.coordinate.longitude
                print("lat:",lat)
                print("lng:",lng)
                //load weather
                if(update){
                    if(mode == 1){
                        requestNhanHang(hero_id: heroID, order_id: order_id, lat: lat.description, lng: lng.description)
                    }else{
                        requestGiaoHang(hero_id: heroID, order_id: order_id, lat: lat.description, lng: lng.description)
                    }
                    update = false
                }
                
            }else{
                lat=location.coordinate.latitude
                lng=location.coordinate.longitude
                print("lat:",lat)
                print("lng:",lng)
                if(update){
                    if(mode == 1){
                        requestNhanHang(hero_id: heroID, order_id: order_id, lat: lat.description, lng: lng.description)
                    }else{
                        requestGiaoHang(hero_id: heroID, order_id: order_id, lat: lat.description, lng: lng.description)
                    }
                    update = false
                }
                
            }
        }
    }
    // If we have been deined access give the user the option to change it
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status == CLAuthorizationStatus.denied) {
            showLocationDisabledPopUp()
        }
    }
    // Show the popup to the user if we have been deined access
    func showLocationDisabledPopUp() {
        let alertController = UIAlertController(title: "Truy cập vị trí đã bị chặn",
                                                message: "Chúng tôi cần bạn đồng ý cung cấp vị trí",
                                                preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
            if let url = URL(string:UIApplicationOpenSettingsURLString) {
//                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                }
            }
        }
        alertController.addAction(openAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func nhanhang(_ sender: UIButton){
        mode = 1
        let buttonTag = sender.tag
        self.a = buttonTag
        order_id = data[buttonTag].order_id!
        print("tag:",data[buttonTag].hero_id!)
        update = true
        requestLocation()
    }
    @objc func giaohang(_ sender: UIButton){
        mode = 2
        let buttonTag = sender.tag
        self.a = buttonTag
        order_id = data[buttonTag].order_id!
        print("tag:",data[buttonTag].hero_id!)
        update = true
        requestLocation()
    }
    var order_id = "0"
    var data:[Order] = []
    var lat:Double = 0.0
    var lng:Double = 0.0
    var loadedLocation = false
    var mode = 1
    let locationManager = CLLocationManager()
    var update = false
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func requestNhanHang(hero_id:String,order_id:String,lat:String,lng:String){
        let headers: HTTPHeaders = [
            "X-API-KEY": "\(tokenlogin)",
            "Accept": "application/json"
        ]
        let test = "http://shipx.vn/api/index.php/VinterWoking/?hero_id=\(hero_id)&order_id=\(order_id)&lat=\(lat)&long=\(lng)"
        print(test)
        Alamofire.request("http://shipx.vn/api/index.php/VinterWoking/?hero_id=\(hero_id)&order_id=\(order_id)&lat=\(lat)&long=\(lng)",headers: headers).responseJSON {(response) in
            
            let Value = response.result.value as! NSDictionary
            let Status = Value["status"] as! String
            let response = Value["response"] as? Any
            print("res",response)
//            let thuho = Int(self.data[self.a].fee!)!
//            print(thuho)
//            let tongtien = Int(self.data[self.a].fee!)! + Int (self.data[self.a].money_first!)!
//            let  khoangcach = self.data[self.a].distance
            if(Status == "success"){
                let alertController = UIAlertController(title: "Thông Báo", message: "Cập nhật trạng thái đơn hàng thành công", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default) {
                    UIAlertAction in
                    NSLog("OK Pressed")
                    let appearance = SCLAlertView.SCLAppearance(
                        showCloseButton: false
                    )
                    let alert = SCLAlertView(appearance: appearance).showWait("Đang chuyển trang", subTitle: "Vui lòng chờ...", closeButtonTitle: nil, timeout: nil, colorStyle: nil, colorTextButton: 0x3f4449, circleIconImage: nil, animationStyle: SCLAnimationStyle.topToBottom)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                        alert.close()
                        
                    }
                    if MFMessageComposeViewController.canSendText(){
                        let controller = MFMessageComposeViewController()
                        //*SMS1: [param0] bat đau di [param1], voi khoang cach la [x km], tong phi ship + tien hang la: [x vnd + y vnd], quy khach luon mo dien thoai và chuan bi tien thanh toan. Xin cam on!
                      //  let khoangcach = data[indexPath.row]
                        controller.body = "Shiper bắt đầu đi giao hàng, với khoảng cách là: \(self.data[self.a].distance!)Km, tổng phí ship + tiền hàng là: \(self.data[self.a].total!)đ, Phiền quý khách luôn mở điện thoại để không bỏ lỡ đơn hàng. Xin cam on!"
                        let number = self.data[self.a].phone_number ?? ""
                        if(number.count>0){
                            controller.recipients = ["\(self.data[self.a].phone_number!)"]
                            controller.messageComposeDelegate = self
                            self.present(controller,animated: true, completion: nil)
                            print("oke=====================")
                        }else{
                            print("loi=====================")
                        }
                    }else{
                        print("loi=====================")
                    }
                }
//                alertController.addAction(action1)
//                self.present(alertController, animated: true, completion: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }else{
              //  if let stringResults = response as? String {
                if (response as? String) != nil {
                    // obj is a string array. Do something with stringArray
                    showAlert(msg: response as! String, view: self)
                }else{
                    showAlert(msg: "Có lỗi xảy ra!", view: self)
                }
                
                print("loi.....")
            }
            DispatchQueue.main.async {
                self.loadWorking()
            }
        }
    }
    func requestGiaoHang(hero_id:String,order_id:String,lat:String,lng:String){
        let headers: HTTPHeaders = [
            "X-API-KEY": "\(tokenlogin)",
            "Accept": "application/json"
        ]
        Alamofire.request("http://shipx.vn/api/index.php/OrderSuccess/?hero_id=\(hero_id)&order_id=\(order_id)&lat=\(lat)&long=\(lng)",headers: headers).responseJSON {(response) in
            
            let Value = response.result.value as! NSDictionary 
            let Status = Value["status"] as! String
            let response = Value["response"] as! String
            
            if(Status == "success"){
                showAlert(msg: "Cập nhật trạng thái đơn hàng thành công", view: self)
                
            }else{
                showAlert(msg: response, view: self)
            }
            DispatchQueue.main.async {
                self.loadWorking()
            }
        }
    }
    
    func loadWorking(){
        let headers: HTTPHeaders = [
            "X-API-KEY": "\(tokenlogin)",
            "Accept": "application/json"
        ]
        Alamofire.request("http://shipx.vn/api/index.php/VinterGetWorking/?hero_id=\(heroID)&service=3&status=2&start_date=20-07-2018&end_date=\(DateWorking)&start=0",headers: headers).responseJSON {(response) in
            
            let Value = response.result.value as! NSDictionary
            let Status = Value["status"] as! String
            
            
            if(Status == "success"){
//                let a = Status.count
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
                    
                    print("===========================================")
                }
                //
                DispatchQueue.main.async {
                    self.table.reloadData()
                }
            }
            
        }
    }
    
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadWorking()
    }

}
