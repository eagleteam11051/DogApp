//
//  a.swift
//  DogApp
//
//  Created by Admin on 7/4/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import UIKit
var name:String = ""
var heroID:String = ""
var tien:String = ""
var diachi:String = ""
var linkima:String = ""
var tokenlogin: String = " "
var Latitude: String = " "
var Longitude: String = " "
var LatitudeGiao: String = " "
var LongitudeGiao: String = " "
var AddressGiao: String = " "
var AddressNhan: String = " "
var tokenfb: String = " "

var Distance: String = " "
var DiemNhan : String = " "
var DiemGiao : String = " "
var KhoangCach: String = " "
var mail :String = " "
var pass :String = " "
func showAlert(msg:String,view:UIViewController){
    // Create the alert controller
    let alertController = UIAlertController(title: "Thông Báo", message: msg, preferredStyle: .alert)
    
    // Create the actions
    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
        UIAlertAction in
        NSLog("OK Pressed")
    }
    
    // Add the actions
    alertController.addAction(okAction)
    // Present the controller
    view.present(alertController, animated: true, completion: nil)
}
