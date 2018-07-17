//
//  Order.swift
//  DogApp
//
//  Created by Admin on 7/13/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
//"response": [
//{
//"id": "503",
//"hero_id": "16",
//"customer_id": "0",
//"message": "m",
//"created_time": "08:19, 14-07-2018",
//"status": "2"
//},

struct Order:Codable{
    let order_id:String?
    let order_code:String?
    let create_time:String?
    let fee:String?
    let percent:String?
    let money_first:String?
    let status:String?
    let note:String?
    let description:String?
    let picture:String?
    let shipping_type:String?
    let distance:String?
    let cleaning_option:String?
    let cleaning_date:String?
    let cleaning_time:String?
    let service_id:String?
    let hero_id:String?
    let customer_id:String?
    let update_time:String?
    let status_name:String?
    let time_working_request:String?
    let pickup:pickup?
    let dropoff:dropoff?
    let service:String?
    let total:String?
    
}
struct pickup:Codable{
    let pickup_id:String?
    let mobile:String?
    let address:String?
    let latitude:String?
    let longitude:String?
    let create_date:String?
}
struct dropoff:Codable {
    let pickup_id:String?
    let mobile:String?
    let address:String?
    let latitude:String?
    let longitude:String?
    let create_date:String?
}
