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

    var udacityStudents = [UdacityStudent]()
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    func logoutTapped(sender: AnyObject) {

        PFUser.logOutInBackground()
        self.dismissViewControllerAnimated(true, completion: nil)

    }
    func refreshTapped(sender: AnyObject) {

        addAnnotations()

    }

    func addTapped(sender: AnyObject) {
    
        let pvc = self.storyboard?.instantiateViewControllerWithIdentifier("postingViewController") as! PostingViewController
        self.presentViewController(pvc, animated: true, completion: nil)

    }
    
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {

        super.viewDidLoad()
        addButtonsToNavbar()
        addAnnotations()

    }

    func addButtonsToNavbar() {

        let pin = UIImage(named: "pin")
        let addAnnotationButton = UIBarButtonItem(image: pin, style: .Plain, target: self, action: "addTapped:")
        let logoutButton = UIBarButtonItem(title: "Logout", style: .Plain, target: self, action: "logoutTapped:")
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: "refreshTapped:")
        self.navigationItem.leftBarButtonItem = logoutButton
        self.navigationItem.rightBarButtonItems = [refreshButton, addAnnotationButton]

    }

    func addAnnotations() {

        fetchStudentLocation()
        activityIndicator.stopAnimating()
        mapView.addAnnotations(udacityStudents)
        mapView.showAnnotations(udacityStudents, animated: true)

    }

    func fetchStudentLocation() {

        if ParseClient.sharedInstance.studentInfo != nil {

            self.mapView.removeAnnotations(udacityStudents)

        }
        ParseClient.sharedInstance.taskForGetMethod(100)
        while ParseClient.sharedInstance.studentInfo == nil {

            self.activityIndicator.hidden = false
            self.activityIndicator.startAnimating()

        }
        for item in ParseClient.sharedInstance.studentInfo! {
        
            let studentInfo = UdacityStudent.createAnInstance(item)
            self.udacityStudents.append(studentInfo!)

        }
        self.activityIndicator.stopAnimating()

    }

    struct Constants {

        static let reuseId = "pin"

    }

    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {

        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(Constants.reuseId) as? MKPinAnnotationView

        if pinView == nil {

            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: Constants.reuseId)
            pinView!.canShowCallout = true
            pinView!.pinColor = .Red
            pinView!.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as! UIButton

        } else {

            pinView!.annotation = annotation

        }
        
        return pinView

    }

    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {

        if control == view.rightCalloutAccessoryView {

            let app = UIApplication.sharedApplication()
            app.openURL(NSURL(string: view.annotation.subtitle!)!)
            
        }
        


    }

    func statusCodeChecker(statusCode: Int) {

        switch statusCode {

        case 400:
            self.displayAlertView("Sorry, we couldn't get data for you...")
        default:
            break

        }

    }

    func displayAlertView(message: String) {

        let alertController = UIAlertController(title: "Data loading Failed", message: message, preferredStyle: .Alert)

        let action = UIAlertAction(title: "OK", style: .Default) { (action) in

            self.dismissViewControllerAnimated(true, completion: nil)

        }

        alertController.addAction(action)
        self.presentViewController(alertController, animated: true, completion: nil)

    }

}
