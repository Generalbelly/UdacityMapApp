//
//  UdacityViewController.swift
//  OnTheMap
//
//  Created by ShimmenNobuyoshi on 2015/05/03.
//  Copyright (c) 2015年 Shimmen Nobuyoshi. All rights reserved.
//

import UIKit
import WebKit

class UdacityViewController: UIViewController, WKNavigationDelegate {

    var wkWebView: WKWebView?
    var urlString: String?
    @IBOutlet weak var navBar: UINavigationBar!
    @IBAction func cancelTapped(sender: AnyObject) {

        self.dismissViewControllerAnimated(true, completion: nil)

    }

    override func viewDidLoad() {

        super.viewDidLoad()
        let frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y + navBar.frame.height + CGFloat(20), width: self.view.frame.width, height: self.view.frame.height - (navBar.frame.height + CGFloat(20)))
        wkWebView = WKWebView(frame: frame)
        wkWebView!.navigationDelegate = self
        wkWebViewConfig()
        self.view.addSubview(wkWebView!)

    }

    func wkWebViewConfig() {

        let url = NSURL(string: urlString!)
        let req = NSURLRequest(URL: url!)
        wkWebView!.loadRequest(req)

    }

}
