//
//  UdacityWaypoint.swift
//  OnTheMap
//
//  Created by ShimmenNobuyoshi on 2015/05/09.
//  Copyright (c) 2015年 Shimmen Nobuyoshi. All rights reserved.
//

import Foundation

class UdacityWaypoint: NSObject {

    var latitude: Double
    var longitude: Double
    var name: String
    var info: String?

    init(latitude: Double, longitude: Double, name: String, info: String?) {

        self.latitude = latitude
        self.longitude = longitude
        self.name = name
        self.info = info

    }

}