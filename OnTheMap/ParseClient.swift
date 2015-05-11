//
//  ParseClient.swift
//  OnTheMap
//
//  Created by ShimmenNobuyoshi on 2015/05/09.
//  Copyright (c) 2015年 Shimmen Nobuyoshi. All rights reserved.
//

import Foundation

class ParseClient: NSObject {

    static let sharedInstance = ParseClient()

    var mvc = MapViewController()

    var session: NSURLSession
    var objectId: String?
    var annotations: [[String: AnyObject]]? { didSet { mvc.data = annotations! } }
    var uniqueKey: String?
    var firstName: String?
    var lastName: String?
    var mapString: String?
    var mediaURL: String?
    var latitude: Double?
    var longitude: Double?


    override init() {

        session = NSURLSession.sharedSession()
        super.init()

    }

    func taskForPostMethod(n: Int) {

        let urlString = ParseClient.Constants.URL
        let url = NSURL(string: urlString)
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = "{\"uniqueKey\": \"\(self.uniqueKey)\", \"firstName\": \"\(self.firstName)\", \"lastName\": \"\(self.lastName)\",\"mapString\": \"\(self.mapString)\", \"mediaURL\": \"\(self.mediaURL)\",\"latitude\": \(self.latitude), \"longitude\": \(self.longitude)}".dataUsingEncoding(NSUTF8StringEncoding)
        let task = session.dataTaskWithRequest(request) { data, response, downloadingError in

            if let res = response as? NSHTTPURLResponse {

                if res.statusCode != 200 {

                    dispatch_async(dispatch_get_main_queue()) {

                        let statusCode = res.statusCode
                        self.mvc.statusCodeChecker(statusCode)

                    }

                }

            }

            if downloadingError != nil {

                dispatch_async(dispatch_get_main_queue()) {

                    self.mvc.displayAlertView("Networking Error")

                }

            } else {

                var error: NSError?
                if let parsedData = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &error) as? NSDictionary {

                    if let objectId = parsedData["objectId"] as? String {

                        self.objectId = objectId

                    }

                }

            }

        }

        task.resume()

    }

    func taskForGetMethod(limit: Int) {

        let urlString = ParseClient.Constants.URL + "?limit=\(limit)"
        let url = NSURL(string: urlString)
        let request = NSMutableURLRequest(URL: url!)
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        let task = session.dataTaskWithRequest(request) { data, response, downloadingError in

            if let res = response as? NSHTTPURLResponse {
                println(res)
                if res.statusCode != 200 {

                    dispatch_async(dispatch_get_main_queue()) {

                        let statusCode = res.statusCode
                        self.mvc.statusCodeChecker(statusCode)

                    }

                }

            }

            if downloadingError != nil {

                dispatch_async(dispatch_get_main_queue()) {

                    self.mvc.displayAlertView("Networking Error")

                }

            } else {

                var error: NSError?
                if let parsedData = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &error) as? NSDictionary {

                    if let allTheAnnotations = parsedData["results"] as? [[String : AnyObject]] {
                        self.annotations = allTheAnnotations

                    }

                }

            }

        }

        task.resume()

    }
    
}

