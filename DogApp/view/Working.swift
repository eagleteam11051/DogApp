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

class Working: UIViewController ,UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "workingcell", for: indexPath) as! WorkingCell
        cell.note.text = data[indexPath.row].description
        cell.time.text = data[indexPath.row].create_time
       
        cell.nhanhang.tag = indexPath.row
        if(data[indexPath.row].status == "5"){
            cell.nhanhang.backgroundColor = UIColor.green
            cell.nhanhang.setTitle("Đã Nhận", for: .normal)
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
            if let url = URL(string: UIApplicationOpenSettingsURLString) {
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
        order_id = data[buttonTag].order_id!
        print("tag:",data[buttonTag].hero_id!)
        update = true
        requestLocation()
    }
    @objc func giaohang(_ sender: UIButton){
        mode = 2
        let buttonTag = sender.tag
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

    
    func requestNhanHang(hero_id:String,order_id:String,lat:String,lng:String){
        let headers: HTTPHeaders = [
            "X-API-KEY": "\(tokenlogin)",
            "Accept": "application/json"
        ]
        Alamofire.request("http://shipx.vn/api/index.php/VinterWoking/?hero_id=\(hero_id)&order_id=\(order_id)&lat=\(lat)&long=\(lng)",headers: headers).responseJSON {(response) in
            
            let Value = response.result.value as! NSDictionary
            let Status = Value["status"] as! String
            let response = Value["response"] as? Any
            print("res",response)
            
            if(Status == "success"){
                showAlert(msg: "Cập nhật trạng thái đơn hàng thành công", view: self)
            }else{
                if let stringResults = response as? String {
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
        Alamofire.request("http://shipx.vn/api/index.php/VinterGetWorking/?hero_id=\(heroID)&service=3&status=2&start_date=21-06-2018&end_date=30-07-2018&start=0",headers: headers).responseJSON {(response) in
            
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
        // Do any additional setup after loading the view.
    }


}
