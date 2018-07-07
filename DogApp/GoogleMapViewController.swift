//
//  GoogleMapViewController.swift
//  DogApp
//
//  Created by Admin on 7/4/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import GoogleMaps

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

class GoogleMapViewController: UIViewController {
    var mapView:GMSMapView?
    var currentDestination: VacationDestination?
    let destinations = [VacationDestination(name: "SFD airport", location: CLLocationCoordinate2D(latitude: 21.585219, longitude: 105.806863), zoom: 15)]
    override func viewDidLoad() {
        super.viewDidLoad()
        GMSServices.provideAPIKey("AIzaSyD2kiwgq9e1qFi-z2-iEzdcbvloSNOweBo")
        let camera = GMSCameraPosition.camera(withLatitude: 21.594914, longitude: 105.811873, zoom: 6.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        let currentLocation = CLLocationCoordinate2DMake(21.594914, 105.811873)
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
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: Selector(("back")))
            
//            let navi = storyboard?.instantiateViewController(withIdentifier: "navi")
//
//            self.addChild(navi!)
//            navi?.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 0)
//            self.view.addSubview((navi?.view)!)
//            navi?.didMove(toParent: self)
            
        }
    }
  

        
    }
