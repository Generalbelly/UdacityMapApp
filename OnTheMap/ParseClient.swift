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

    var session: NSURLSession
    var objectId: String?
    var studentInfo: [[String: AnyObject]]?
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

    func taskForPostMethod(completionHandler: (success: Bool, res: Int?, error: NSError?) -> Void) {

        let urlString = ParseClient.Constants.URL
        let url = NSURL(string: urlString)
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = "{\"uniqueKey\": \"\(self.uniqueKey!)\", \"firstName\": \"\(self.firstName!)\", \"lastName\": \"\(self.lastName!)\",\"mapString\": \"\(self.mapString!)\", \"mediaURL\": \"\(self.mediaURL!)\",\"latitude\": \(self.latitude!), \"longitude\": \(self.longitude!)}".dataUsingEncoding(NSUTF8StringEncoding)
        let task = session.dataTaskWithRequest(request) { data, response, downloadingError in

            if let res = response as? NSHTTPURLResponse {

                if res.statusCode != 200 {

                    completionHandler(success: false, res: res.statusCode, error: nil)

                }

            }

            if downloadingError != nil {

                completionHandler(success: false, res: nil, error: downloadingError)

            } else {

                var error: NSError?
                if let parsedData = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &error) as? NSDictionary {

                    if let objectId = parsedData["objectId"] as? String {

                        self.objectId = objectId

                    }

                }

                completionHandler(success: true, res: nil, error: nil)

            }

        }

        task.resume()

    }

    func taskForGetMethod(limit: Int, completionHandler: (success: Bool, res: Int?, error: NSError?) -> Void) {

        var dataArray: [[String : AnyObject]]?
        let urlString = ParseClient.Constants.URL + "?limit=\(limit)"
        let url = NSURL(string: urlString)
        let request = NSMutableURLRequest(URL: url!)
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        let task = session.dataTaskWithRequest(request) { data, response, downloadingError in

            if let res = response as? NSHTTPURLResponse {

                if res.statusCode != 200 {

                    completionHandler(success: false, res: res.statusCode, error: downloadingError)

                }

            }

            if downloadingError != nil {

                completionHandler(success: false, res: nil, error: downloadingError)

            } else {

                var error: NSError?
                if let parsedData = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &error) as? NSDictionary {

                    if let allTheData = parsedData["results"] as? [[String : AnyObject]] {
                        self.studentInfo = allTheData

                    }

                }

                completionHandler(success: true, res: nil, error: nil)

            }

        }

        task.resume()

    }

    
}

