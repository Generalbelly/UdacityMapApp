//
//  MapViewController.swift
//  OnTheMap
//
//  Created by ShimmenNobuyoshi on 2015/05/04.
//  Copyright (c) 2015年 Shimmen Nobuyoshi. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    var data: [[String: AnyObject]]? { didSet { self.annotations = self.createAnnotations(data!) } }
    var annotations: [UdacityWaypoint]? { didSet { beginAnnotation() } }

    //var testMap = MKMapView()
    
    @IBOutlet weak var mapView: MKMapView! { didSet { ParseClient.sharedInstance.taskForGetMethod(100) } }
    @IBAction func logoutTapped(sender: AnyObject) {

        PFUser.logOutInBackground()
        self.dismissViewControllerAnimated(true, completion: nil)

    }

    override func viewDidLoad() {

        super.viewDidLoad()

    }

    override func viewDidAppear(animated: Bool) {

        super.viewDidAppear(animated)

    }

    func beginAnnotation() {

        mapView.addAnnotations(annotations)

    }

    
    func createAnnotations(data: [[String: AnyObject]]) -> [UdacityWaypoint] {

        var array = [UdacityWaypoint]()

        for item in data {

            var firstName = item["firstName"] as! String
            var lastName = item["lastName"] as! String
            var latitude = item["latitude"] as! Double
            var longitude = item["longitude"] as! Double
            var info = item["mediaURL"] as! String?
            var annotation = UdacityWaypoint(latitude: latitude, longitude: longitude, name: "\(firstName) \(lastName)", info: info)
            array.append(annotation)

        }

        return array

    }

//    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView? {
//        
//        let reuseId = "pin"
//
//        if annotation.isKindOfClass(UdacityWaypoint) {
//
//            var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
//
//            if pinView == nil {
//                pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
//                pinView!.canShowCallout = true
//                pinView!.pinColor = .Red
//                pinView!.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as! UIButton
//            }
//            else {
//                pinView!.annotation = annotation
//            }
//            
//            return pinView
//
//        }
//
//        return nil
//    }


    func statusCodeChecker(statusCode: Int) {

        switch statusCode {

        case 403:
            self.displayAlertView("Sorry, we couldn't get data for you...")
        default:
            break

        }

    }

    func displayAlertView(message: String) {

        let alertController = UIAlertController(title: "Login Failed", message: message, preferredStyle: .Alert)

        let action = UIAlertAction(title: "OK", style: .Default) { (action) in

            self.dismissViewControllerAnimated(true, completion: nil)

        }

        alertController.addAction(action)
        self.presentViewController(alertController, animated: true, completion: nil)

    }

}
