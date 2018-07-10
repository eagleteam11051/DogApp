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

class GoogleMapViewController: UIViewController,CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    
    var mapView:GMSMapView?
    var currentDestination: VacationDestination?
    let destinations = [VacationDestination(name: "SFD airport", location: CLLocationCoordinate2D(latitude: 21.585219, longitude: 105.806863), zoom: 15)]
    
    let a:CLLocationManager = CLLocationManager()
    override func viewDidLoad() {
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        super.viewDidLoad()
        GMSServices.provideAPIKey("AIzaSyD2kiwgq9e1qFi-z2-iEzdcbvloSNOweBo")
            let locValue: CLLocationCoordinate2D = a.location!.coordinate
            print("dia chi : \(locValue.latitude)    \(locValue.longitude)")
            let camera = GMSCameraPosition.camera(withLatitude: locValue.longitude, longitude: locValue.longitude, zoom: 6.0)
            mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
            view = mapView
        
        
        
        let currentLocation = CLLocationCoordinate2DMake(locValue.latitude, locValue.longitude)
        let market = GMSMarker(position: currentLocation)
        market.title = "Tesst"
        market.map = mapView
        // nut 2
        if currentDestination == nil{
            currentDestination  = destinations.first
            mapView?.camera = GMSCameraPosition.camera(withTarget: (currentDestination?.location)!, zoom: 15)
            let market = GMSMarker(position: (currentDestination?.location)!)
            market.title = "test2"
            market.snippet = "Dong 2"
           market.icon = UIImage(named: "bike")
            market.map = mapView

            
        }
    }
    }
