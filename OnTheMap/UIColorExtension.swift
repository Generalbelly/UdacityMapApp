//
//  UIColorExtension.swift
//  OnTheMap
//
//  Created by ShimmenNobuyoshi on 2015/05/17.
//  Copyright (c) 2015年 Shimmen Nobuyoshi. All rights reserved.
//

import UIKit

extension UIColor {

    class func rgb(r: Int, g: Int, b: Int, alpha: CGFloat) -> UIColor{
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)

    }

}
