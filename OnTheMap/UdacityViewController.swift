//
//  UdacityViewController.swift
//  OnTheMap
//
//  Created by ShimmenNobuyoshi on 2015/05/03.
//  Copyright (c) 2015年 Shimmen Nobuyoshi. All rights reserved.
//

import UIKit
import WebKit

class UdacityViewController: UIViewController {

    var wkWebView: WKWebView?
    var urlString = UdacityClient.Constants.UdacityURL
    @IBOutlet weak var udacityView: UIView!

    override func viewDidLoad() {

        super.viewDidLoad()
        wkWebView = WKWebView()

    }

    override func viewWillAppear(animated: Bool) {

        super.viewWillAppear(animated)
        wkWebViewConfig()
        udacityView.addSubview(wkWebView!)

    }

    func wkWebViewConfig() {

        wkWebView?.frame = udacityView.frame
        let url = NSURL(string: urlString)
        let req = NSURLRequest(URL: url!)
        wkWebView?.loadRequest(req)

    }


}
