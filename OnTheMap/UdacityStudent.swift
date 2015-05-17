//
//  UdacityStudent.swift
//  OnTheMap
//
//  Created by ShimmenNobuyoshi on 2015/05/13.
//  Copyright (c) 2015年 Shimmen Nobuyoshi. All rights reserved.
//

import Foundation

class UdacityStudent: NSObject {

    let latitude: Double
    let longitude: Double
    let name: String
    var info: String

    init(latitude: Double, longitude: Double, name: String, info: String) {

        self.latitude = latitude
        self.longitude = longitude
        self.name = name
        self.info = info

        super.init()

    }

        class func createAnInstance(data: [String: AnyObject]) -> UdacityStudent? {

        var firstName = data["firstName"] as! String
        var lastName = data["lastName"] as! String
        var latitude = data["latitude"] as! Double
        var longitude = data["longitude"] as! Double
        var info = data["mediaURL"] as! String
        var annotation = UdacityStudent(latitude: latitude, longitude: longitude, name: "\(firstName) \(lastName)", info: info)

        return UdacityStudent(latitude: latitude, longitude: longitude, name: "\(firstName) \(lastName)", info: info)
    }

}