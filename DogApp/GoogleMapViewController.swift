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

class GoogleMapViewController: UIViewController,CLLocationManagerDelegate, GMSMapViewDelegate {
    
    

    func loadLocation(){
        let headers: HTTPHeaders = [
            "X-API-KEY": "44wkgccggkgo4gccc80040s84k8cg8kscgck80c0",
            "Accept": "application/json"
        ]
        Alamofire.request("http://shipx.vn/api/index.php/VinterGetNewJobs/?hero_id=16&service=3",headers: headers).responseJSON {(response) in
            let Value = response.result.value as! NSDictionary
            let Status = Value["status"]
            //let Response = Value["response"] as! [[String: Any]]
            
//            print("response",Status)
//            print("response",Value["response"])
            let res = Value["response"] as! [[String: Any]]
            
            for item in res{
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
                market.position = currentLocation
                market.accessibilityLabel = Distance
                market.snippet = AddressGiao
                market.title = AddressNhan
                market.map = self.mapView
                market.icon = UIImage(named: "bike")
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
        print(DiemNhan)
        print(DiemGiao)
        let jobView = self.storyboard?.instantiateViewController(withIdentifier: "jobview")
        self.present(jobView!, animated: true, completion: nil)
        return true
    }
    
    override func loadView() {
        let camera = GMSCameraPosition.camera(withLatitude: 21.5961536, longitude: 105.8121259  , zoom: 11.3759)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        mapView?.delegate = self
//        let market = GMSMarker()
//        market.position = CLLocationCoordinate2D(latitude: 21, longitude: 105)
//        market.title = "hihi"
//        market.snippet = "hehe"
//        market.map = mapView
    }
    }
