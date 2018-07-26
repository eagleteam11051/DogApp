//
//  HomePageViewController.swift
//  DogApp
//
//  Created by Admin on 7/3/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation


class HomePageViewController: UIViewController,CLLocationManagerDelegate {
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
    var repeatCount = 0
    var lat:Double = 0.0
    var lng:Double = 0.0
    var update = false
    let locationManager = CLLocationManager()
    var loadedLocation = false



    
    func hoSo(){
        let headers: HTTPHeaders = [
            "X-API-KEY": "8s0wswowcgc4owoc0oc8g00cwok8gkw800k8o08w"]
        Alamofire.request("http://shipx.vn/api/index.php/VinterSignin/?mobile=\(mail1)&password=\(pass1)&token=\(tokenfb)&phone_os=2",headers: headers).responseJSON {(response) in
            print("value",response)
            let Value = response.result.value as! [String: Any]
            let Status = Value["status"] as! String
            print(Status)
            if (Status == "success"){
                print("da oke")
                var Response = Value["response"] as! [String: Any]
                //let Token = Response["token"] as! String
                heroID  = Response["hero_id"] as! String
                name  = Response["fullname"] as? String ?? " "
                tien = Response["balance"] as? String ?? " "
                diachi = Response["address"] as? String ?? " "
                linkima = Response["image"] as? String ?? " "
                tokenlogin = Response["token"] as? String ?? " "
                sdt = Response["mobile"] as? String ?? " "
                print(tokenlogin)
            }
            
        }
    }
    @IBAction func btnThongbao(_ sender: Any) {
        let Thongbao = self.storyboard?.instantiateViewController(withIdentifier: "Thongbao")
        self.present(Thongbao!, animated: true, completion: nil)
    }
    @IBAction func reload(_ sender: Any) {
        loadOrder()
    }
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
        loadDate()
        txtName.text = name
        txtHeroID.text = heroID
        txtTaiKhoan.text = "\(tien)đ"
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
        loadOrder()
        update = true
        requestLocation()
        
        var helloWorldTimer = Timer.scheduledTimer(timeInterval: 30.0, target: self, selector: #selector(reloadTask(tapGestureRecognizer:)), userInfo: nil, repeats: true)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        loadDate()
        
    }
    @objc func reloadTask(tapGestureRecognizer: UITapGestureRecognizer){
        if(repeatCount==0){
            update = true
            requestLocation()
        }
        repeatCount = repeatCount + 1
        if(repeatCount == 2){
            repeatCount = 0
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
                    postMyLocation(lat:lat,lng:lng)
                    update = false
                }
                
            }else{
                lat=location.coordinate.latitude
                lng=location.coordinate.longitude
                print("lat:",lat)
                print("lng:",lng)
                if(update){
                    postMyLocation(lat:lat,lng:lng)
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
    
    func postMyLocation(lat:Double,lng:Double){
        print("postmylocation: \(lat)-\(lng)")
        let headers: HTTPHeaders = [
            "X-API-KEY": "\(tokenlogin)",
            "Accept": "application/json"
        ]
        Alamofire.request("http://shipx.vn/api/index.php/VinterSendGeoLocation/?hero_id=\(heroID)&latitude=\(lat)&longitude=\(lng)",headers: headers).responseJSON {(response) in
            let Value = response.result.value as! NSDictionary
           // let Status = Value["status"]
            //let Response = Value["response"] as! [[String: Any]]
            
            //            print("response",Status)
            //            print("response",Value["response"])
            let res = Value["response"] as! Any
            DispatchQueue.main.async {
                //self.tnumber1.text = res.count.description
                print("updateMyLocation:",res)
            }
        }
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
    
    override func viewWillAppear(_ animated: Bool) {
        tnumber2.text = "0"
        loadOrder()
        hoSo()
        viewDidLoad()
    }
    func loadTimViec(){
        let headers: HTTPHeaders = [
            "X-API-KEY": "\(tokenlogin)",
            "Accept": "application/json"
        ]
        Alamofire.request("http://shipx.vn/api/index.php/VinterGetNewJobs/?hero_id=\(heroID)&service=3",headers: headers).responseJSON {(response) in
            let Value = response.result.value as! NSDictionary
            let Status = Value["status"]
            //let Response = Value["response"] as! [[String: Any]]
            
            //            print("response",Status)
            //            print("response",Value["response"])
            let res = Value["response"] as! [[String: Any]]
            DispatchQueue.main.async {
                self.tnumber1.text = res.count.description

            }
        }
    }
    func loadChoDuyet(){
        let headers: HTTPHeaders = [
            "X-API-KEY": "\(tokenlogin)",
            "Accept": "application/json"
        ]
        Alamofire.request("http://shipx.vn/api/index.php/VinterGetOrders/?hero_id=\(heroID)&status=9&start_date=21-06-2018&end_date=\(DateWorking)&start=0",headers: headers).responseJSON {(response) in
            let Value = response.result.value as! NSDictionary
            print(Value)
            let Status = Value["status"] as! String
            if(Status == "success"){
                let res = Value["response"] as! [[String: Any]]
                //
                DispatchQueue.main.async {
                    self.tnumber2.text = res.count.description
                }
            }
            
        }
    }
    func loadDangLam(){
        let headers: HTTPHeaders = [
            "X-API-KEY": "\(tokenlogin)",
            "Accept": "application/json"
        ]
        Alamofire.request("http://shipx.vn/api/index.php/VinterGetWorking/?hero_id=\(heroID)&service=3",headers: headers).responseJSON {(response) in
            let Value = response.result.value as! NSDictionary
            let Status = Value["status"] as! String
            if(Status == "success"){
                let a = Status.count
                let res = Value["response"] as! [[String: Any]]
                
                //
                DispatchQueue.main.async {
                    self.tnumber3.text = res.count.description
                }
            }
            
        }
    }
    func loadDaLam(){
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
                
                //
                DispatchQueue.main.async {
                    self.tnumber4.text = res.count.description
                }
            }
            
        }
    }
    func loadDate(){
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "el_GR") as Locale
        dateFormatter.dateStyle = DateFormatter.Style.long
        let currentDate = NSDate()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let convertedDate = dateFormatter.string(from: currentDate as Date)
        print(convertedDate)
        DateWorking = convertedDate
        
    }
    func loadOrder(){
        loadTimViec()
        loadChoDuyet()
        loadDangLam()
        loadDaLam()
    }
    
    
}
