//
//  GoogleMapViewController.swift
//  DogApp
//
//  Created by Admin on 7/4/18.
//  Copyright © 2018 Admin. All rights reserved.
//
import UIKit
import GoogleMaps
import CoreLocation
import Alamofire
import SwiftyJSON
class VacationDestination: NSObject {
    let name: String
    let location: CLLocationCoordinate2D
    let zoom: Float
    
    init(name:String, location: CLLocationCoordinate2D,zoom: Float){
        self.name = name
        self.location = location
        self.zoom = zoom
    }
}

class GoogleMapViewController: UIViewController,CLLocationManagerDelegate, GMSMapViewDelegate,navitimviec {
    func back() {
        self.dismiss(animated: true, completion: nil)
    }
    
    var data:[Order] = []
    
    func getJob(tag:String)->Order?{
        for job in data{
            if tag == job.order_id{
                return job
            }
        }
        return nil
    }
    func getGroupJob(job:Order)-> [Order]{
        var jobs:[Order] = []
        for item in data{
            let lat1:String = (job.pickup?.latitude)!
            let lng1:String = (job.pickup?.longitude)!
            let lat2:String = (item.pickup?.latitude)!
            let lng2:String = (item.pickup?.longitude)!
            if(distance(lat1: Double(lat1)!,lng1: Double(lng1)!,lat2: Double(lat2)!,lng2: Double(lng2)!)<100){
                jobs.append(item)
            }
        }
        return jobs
    }
    

    func loadLocation(){
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
            
            for item in res{
                Order_id = item["order_id"] as! String
                Distance = item["distance"] as! String
                let dropoff = item["dropoff"] as! [String: Any]
                AddressGiao = dropoff["address"]! as! String
                //print("DiemGiao",AddressGiao)
                LatitudeGiao = dropoff["latitude"]! as! String
                // print(LatitudeGiao)
                LongitudeGiao = dropoff["longitude"]! as! String
                //print(LongitudeGiao)
                let pickup = item["pickup"] as! [String: Any]
                 AddressNhan = pickup["address"]! as! String
                print("Diem Nhan: ",AddressNhan)
                print("DiemGiao",AddressGiao)
                 Latitude = pickup["latitude"]! as! String
                print(Latitude)
                Longitude = pickup["longitude"]! as! String
                print(Longitude)
                print("===========================================")
                //self.view.addSubview(self.mapView!)
                var currentLocation = CLLocationCoordinate2D(latitude: Double(Latitude)!, longitude: Double(Longitude)!)
                print(Double(Latitude)!)
                print("currentLocation",currentLocation)
                var market = GMSMarker()
                
                market.accessibilityValue = Order_id
                market.position = currentLocation
                market.accessibilityLabel = Distance
                market.snippet = AddressGiao
                market.title = AddressNhan
                market.map = self.mapView
                market.icon = UIImage(named: "bike")
                do{
                    let jsonData = try? JSONSerialization.data(withJSONObject: item, options: [])
                    let jsonString:String = String(data: jsonData!, encoding: .utf8)!
                    print("jsonString:",jsonString)
                    let order = try JSONDecoder().decode(Order.self, from: jsonString.data(using: .utf8)!)
                    self.data.append(order)
                }catch let e{
                    print("error",e)
                }
            }
        }
    }
    
    
    
    let locationManager = CLLocationManager()
    
    var mapView:GMSMapView?
    var currentDestination: VacationDestination?

    
    let a:CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        loadLocation()
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print("******************************************************************")
        KhoangCach = marker.accessibilityLabel!
        DiemNhan = marker.title!
        DiemGiao = marker.snippet!
        MaDon = marker.accessibilityValue!
        print(DiemNhan)
        print(DiemGiao)
        let jobView = self.storyboard?.instantiateViewController(withIdentifier: "jobview") as! JobViewController
        
        jobView.data = getGroupJob(job: getJob(tag: marker.accessibilityValue!)!)
            
        self.present(jobView, animated: true, completion: nil)
        return true
    }
    
    override func loadView() {
        let camera = GMSCameraPosition.camera(withLatitude: 21.5961536, longitude: 105.8121259  , zoom: 11.3759)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        mapView?.delegate = self
        mapView?.isMyLocationEnabled = true
//        let market = GMSMarker()
//        market.position = CLLocationCoordinate2D(latitude: 21, longitude: 105)
//        market.title = "hihi"
//        market.snippet = "hehe"
//        market.map = mapView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        addSub()
    }
    
    func addSub(){
        let chucNangTren = storyboard!.instantiateViewController(withIdentifier: "navitimviec") as? NaviTimViec
        chucNangTren?.dele = self
        self.addChildViewController(chucNangTren!)
        var fra:CGRect
        if(self.view.frame.height>800){
            fra = CGRect(x: 0, y: 20, width: self.view.frame.width, height: 50)
        }else{
            fra = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
        }
        
        chucNangTren?.view.frame = fra// or better, turn off `translatesAutoresizingMaskIntoConstraints` and then define constraints for this subview
        self.view.addSubview((chucNangTren?.view)!)
        chucNangTren?.didMove(toParentViewController: self)
        //duoi
    }
    
    }



protocol navitimviec {
    func back()
}
