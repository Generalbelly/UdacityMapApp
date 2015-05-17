//
//  UdacityAnnotation.swift
//  OnTheMap
//
//  Created by ShimmenNobuyoshi on 2015/05/09.
//  Copyright (c) 2015年 Shimmen Nobuyoshi. All rights reserved.
//

import MapKit

extension UdacityStudent: MKAnnotation {

    var coordinate: CLLocationCoordinate2D { return CLLocationCoordinate2D(latitude: latitude, longitude: longitude) }

    var title: String { return name }

    var subtitle: String? { return info }

}