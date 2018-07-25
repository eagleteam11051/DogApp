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
var sdt:String = " " 
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
var create_time_int: String = " "
var tokenfb: String = " "
var Order_id: String = " "
var mail1: String = " "
var pass1: String = " "
var DateWorking: String = " "
var Distance: String = " "
var DiemNhan : String = " "
var DiemGiao : String = " "
var KhoangCach: String = " "
var MaDon: String = " "
var thoiGiancon: String = " "
var soTrang: Int = 0
func showAlert(msg:String,view:UIViewController){
    let alertController = UIAlertController(title: "Thông Báo", message: msg, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
        UIAlertAction in
        NSLog("OK Pressed")
    }
    alertController.addAction(okAction)
    view.present(alertController, animated: true, completion: nil)
}
func saveCache(key:String,value:String){
    UserDefaults.standard.setValue(value, forKey: key)
    //print("hihi:\(UserDefaults.standard.value(forKey: "hihi")!)")
}
func getCache(key:String)->String?{
    return UserDefaults.standard.value(forKey: key) as? String
}
