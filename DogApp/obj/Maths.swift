//
//  Maths.swift
//  DogApp
//
//  Created by Admin on 7/16/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
/**
 val theta = lon1 - lon2
 var dist = Math.sin(deg2rad(lat1)) * Math.sin(deg2rad(lat2)) + Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * Math.cos(deg2rad(theta))
 dist = Math.acos(dist)
 dist = rad2deg(dist)
 dist = dist * 60.0 * 1.1515
 dist = dist * 1.609344
 return dist*1000
 
 private fun deg2rad(deg: Double): Double {
 return deg * Math.PI / 180.0
 }
 
 private fun rad2deg(rad: Double): Double {
 return rad * 180.0 / Math.PI
 }
 */

func distance(lat1:Double,lng1:Double,lat2:Double,lng2:Double)->Double{
    let theta = lng1 - lng2
    var dist = sin(deg2rad(deg: lat1)) * sin(deg2rad(deg: lat2)) + cos(deg2rad(deg: lat1)) * cos(deg2rad(deg: lat2)) * cos(deg2rad(deg: theta))
    dist = acos(dist)
    dist = rad2deg(rad: dist)
    dist = dist * 60.0 * 1.1515
    dist = dist * 1.609344
    return dist * 1000
}
func deg2rad(deg:Double)->Double{
    return deg * Double.pi / 180.0
}
func rad2deg(rad:Double)->Double{
    return rad * 180.0 / Double.pi
}

