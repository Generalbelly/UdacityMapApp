//
//  ListViewController.swift
//  OnTheMap
//
//  Created by ShimmenNobuyoshi on 2015/05/04.
//  Copyright (c) 2015年 Shimmen Nobuyoshi. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    var udacityStudents = [UdacityStudent]()
    var urlString: String?

    func logoutTapped(sender: AnyObject) {

        PFUser.logOutInBackground()
        self.dismissViewControllerAnimated(true, completion: nil)

    }

    func refreshTapped(sender: AnyObject) {

        fetchStudentinfo()

    }

    func addTapped(sender: AnyObject) {
    
        let pvc = self.storyboard?.instantiateViewControllerWithIdentifier("postingViewController") as! PostingViewController
        self.presentViewController(pvc, animated: true, completion: nil)

    }

    override func viewDidLoad() {
    
        super.viewDidLoad()
        addButtonsToNavbar()
        fetchStudentinfo()

    }

    func addButtonsToNavbar() {

        let pin = UIImage(named: "pin")
        let addAnnotationButton = UIBarButtonItem(image: pin, style: .Plain, target: self, action: "addTapped:")
        let logoutButton = UIBarButtonItem(title: "Logout", style: .Plain, target: self, action: "logoutTapped:")
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: "refreshTapped:")
        self.navigationItem.leftBarButtonItem = logoutButton
        self.navigationItem.rightBarButtonItems = [refreshButton, addAnnotationButton]

    }


    func fetchStudentinfo() {

        ParseClient.sharedInstance.taskForGetMethod(100) {

             (success: Bool, res: Int?, error: NSError?) -> Void in

            if success == true {

                for item in ParseClient.sharedInstance.studentInfo! {
            
                let studentInfo = UdacityStudent(data: item)
                self.udacityStudents.append(studentInfo)

                }
                self.activityIndicator.stopAnimating()

            } else {

                self.displayError(success, res: res, error:error)

            }


        }
        while udacityStudents.count < 99 {

            self.activityIndicator.hidden = false
            self.activityIndicator.startAnimating()

        }


    }


    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return udacityStudents.count

    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        var cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        if udacityStudents.count > 0 {

            cell.textLabel?.text = udacityStudents[indexPath.row].name

        }
        return cell

    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        self.urlString = udacityStudents[indexPath.row].info ?? UdacityClient.Constants.UdacityURL
        performSegueWithIdentifier("showLink", sender: self)

    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "showLink" {

            if let uvc = segue.destinationViewController as? UdacityViewController {

                uvc.urlString = self.urlString!

            }

        }

    }

    func displayError(success: Bool, res: Int?, error: NSError?) {

        if res != nil {

            self.statusCodeChecker(res!)
            
        } else {

            self.displayAlertView("Networking Error")

        }

    }

    func statusCodeChecker(statusCode: Int) {

        switch statusCode {

        case 401:
            self.displayAlertView("Either username(email) or password is not correct")
        case 403:
            self.displayAlertView("You are not allowed to access to this")
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
