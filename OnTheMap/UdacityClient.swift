//
//  UdacityClient.swift
//  OnTheMap
//
//  Created by ShimmenNobuyoshi on 2015/04/25.
//  Copyright (c) 2015年 Shimmen Nobuyoshi. All rights reserved.
//

import Foundation

class UdacityClient: NSObject {

    static let sharedInstance = UdacityClient()

    var lvc = LoginViewController()

    var session: NSURLSession
    var email: String?
    var password: String?
    var fbToken: String?
    var userId: String? { didSet{ ParseClient.sharedInstance.uniqueKey = userId! } }
    var sessionId: String?
    var firstName: String? { didSet{ ParseClient.sharedInstance.firstName = firstName! } }
    var lastName: String? { didSet{ ParseClient.sharedInstance.lastName = lastName! } }

    override init() {

        session = NSURLSession.sharedSession()

    }

    func taskForPostMethod(n: Int) {

        let urlString = UdacityClient.Constants.PostURL
        let url = NSURL(string: urlString)
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        switch n {

        case 0:
            request.HTTPBody = "{\"udacity\": {\"username\": \"\(self.email!)\", \"password\": \"\(self.password!)\"}}".dataUsingEncoding(NSUTF8StringEncoding)
        case 1:
            request.HTTPBody = "{\"facebook_mobile\": {\"access_token\": \"\(self.fbToken!)\"}}".dataUsingEncoding(NSUTF8StringEncoding)
        default:
            break

        }

        let task = session.dataTaskWithRequest(request) { data, response, downloadingError in

            if let res = response as? NSHTTPURLResponse {

                if res.statusCode != 200 {

                    dispatch_async(dispatch_get_main_queue()) {

                        let statusCode = res.statusCode
                        self.lvc.statusCodeChecker(statusCode)

                    }

                }

            }

            if downloadingError != nil {

                dispatch_async(dispatch_get_main_queue()) {

                    self.lvc.displayAlertView("Networking Error")

                }

            } else {

                let newData = data.subdataWithRange(NSMakeRange(5, data.length - 5))
                var error: NSError?
                if let parsedData = NSJSONSerialization.JSONObjectWithData(newData, options: NSJSONReadingOptions.AllowFragments, error: &error) as? NSDictionary {

                    if let account = parsedData["account"] as? NSDictionary {

                        let key = account["key"] as! String
                        self.userId = key

                    }
                    if let session = parsedData["session"] as? NSDictionary {

                        let id = session["id"] as! String
                        self.sessionId = id

                    }

                }

            }

        }

        task.resume()

    }

    func taskForGetMethod() {

        let urlString = UdacityClient.Constants.GetURL + userId!
        let url = NSURL(string: urlString)
        let request = NSMutableURLRequest(URL: url!)
        let task = session.dataTaskWithRequest(request) { data, response, downloadingError in

            if let res = response as? NSHTTPURLResponse {

                if res.statusCode != 200 {

                    dispatch_async(dispatch_get_main_queue()) {

                        let statusCode = res.statusCode
                        self.lvc.statusCodeChecker(statusCode)

                    }

                }

            }

            if downloadingError != nil {

                dispatch_async(dispatch_get_main_queue()) {

                    self.lvc.displayAlertView("Networking Error")

                }

            } else {

                let newData = data.subdataWithRange(NSMakeRange(5, data.length - 5))
                var error: NSError?
                if let parsedData = NSJSONSerialization.JSONObjectWithData(newData, options: NSJSONReadingOptions.AllowFragments, error: &error) as? NSDictionary {

                    if let userInfo = parsedData["user"] as? NSDictionary {

                        let firstName = userInfo["first_name"] as! String
                        self.firstName = firstName

                        let lastName = userInfo["last_name"] as! String
                        self.lastName = lastName

                    }

                }

            }

        }

        task.resume()

    }

}



