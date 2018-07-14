//
//  BanDoCongViec.swift
//  DogApp
//
//  Created by Admin on 7/13/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import GoogleMaps

class BanDoCongViec: UIViewController,
CLLocationManagerDelegate,
GMSMapViewDelegate,
navi{
    func back() {
        self.dismiss(animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        addSub()

    }
    
    func addSub(){
        let chucNangTren = storyboard!.instantiateViewController(withIdentifier: "navibando") as? NaviBanDo
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

    let locationManager = CLLocationManager()
    
    var mapView:GMSMapView?
    let a:CLLocationManager = CLLocationManager()
    var order:Order?
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print("******************************************************************")
//        KhoangCach = marker.accessibilityLabel!
//        DiemNhan = marker.title!
//        DiemGiao = marker.snippet!
//        print(DiemNhan)
//        print(DiemGiao)
//        let jobView = self.storyboard?.instantiateViewController(withIdentifier: "jobview")
//        self.present(jobView!, animated: true, completion: nil)
        return true
    }
    
    override func loadView() {
        
        mapView?.delegate = self
        let market = GMSMarker()
        let lat1:String = (order?.pickup?.latitude)!
        let lng1:String = (order?.pickup?.longitude)!
        let lat2:String = (order?.dropoff?.latitude)!
        let lng2:String = (order?.dropoff?.longitude)!
        print("lat1",lat1)
        print("lng1",lng1)
        print("lat2",lat2)
        print("lng2",lng2)
        
        let camera = GMSCameraPosition.camera(withLatitude: Double(lat1)!, longitude: Double(lng1)!  , zoom: 11)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        
        market.position = CLLocationCoordinate2D(latitude: Double(lat1)!, longitude: Double(lng1)!)
        market.title = order?.pickup?.address
        market.icon = UIImage(named: "start_blue")
        market.map = mapView
        let market2 = GMSMarker()
        market2.position = CLLocationCoordinate2D(latitude: Double(lat2)!, longitude: Double(lng2)!)
        market2.title = order?.dropoff?.address
        market2.icon = UIImage(named: "end_green")
        market2.map = mapView
        

    }
}

protocol navi {
    func back()
}
