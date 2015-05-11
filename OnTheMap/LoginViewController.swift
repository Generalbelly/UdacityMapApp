//
//  ViewController.swift
//  OnTheMap
//
//  Created by ShimmenNobuyoshi on 2015/04/25.
//  Copyright (c) 2015年 Shimmen Nobuyoshi. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate, FBSDKLoginButtonDelegate {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var fbLoginButton: FBSDKLoginButton!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    var translucentView: UIView?
    let permissions = ["public_profile", "email", "user_friends"]

    @IBAction func loginButtonTapped(sender: AnyObject) {

        var filledOut = (emailField.text.isEmpty, passwordField.text.isEmpty)
        switch filledOut {

        case (true, true):
            self.displayAlertView("You have to enter username and password to log in")
        case (true, false):
            self.displayAlertView("You have to enter username to log in")
        case (false, true):
            self.displayAlertView("You have to enter password to log in")
        case (false, false):
            UdacityClient.sharedInstance.email = emailField.text
            UdacityClient.sharedInstance.password = passwordField.text
            getSessionID(0)
        default:
            break

        }

    }

    func statusCodeChecker(statusCode: Int) {

        switch statusCode {

        case 403:
            self.displayAlertView("Either username(email) or password is not correct")
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



    func getSessionID(n: Int) {

        UdacityClient.sharedInstance.taskForPostMethod(n)
        if UdacityClient.sharedInstance.sessionId != nil {

            self.chooseLoginMethod(n)

        } else {

            while UdacityClient.sharedInstance.sessionId == nil {

                if self.activityIndicator.isAnimating() == false {

                    self.translucentView = UIView(frame: self.view.frame)
                    self.translucentView!.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.5)
                    self.view.addSubview(self.translucentView!)
                    self.activityIndicator.hidden = false
                    self.activityIndicator.startAnimating()

                }

            }

            self.chooseLoginMethod(n)

        }

    }

    func chooseLoginMethod(n: Int) {

        if n == 0 {

            self.normalLogin()

        } else {

            self.fbLogin()

        }

    }

    func normalLogin() {

        PFUser.logInWithUsernameInBackground(UdacityClient.sharedInstance.email!, password:UdacityClient.sharedInstance.password!) { (user: PFUser?, error: NSError?) -> Void in

            if user != nil {

                self.loginCompleted()

            } else {

                var user = PFUser()
                user.username = UdacityClient.sharedInstance.email
                user.password = UdacityClient.sharedInstance.password
                user.email = UdacityClient.sharedInstance.email
                user.signUpInBackgroundWithBlock {(succeeded: Bool, error: NSError?) -> Void in

                    if let error = error {

                        let errorString = error.userInfo?["error"] as? String
                        self.displayAlertView(errorString!)

                    } else {

                        self.loginCompleted()

                    }

                }

            }

        }

    }

    func fbLogin() {

        PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions) {
          (user: PFUser?, error: NSError?) -> Void in

            if user == nil {

                self.displayAlertView("Facebook login was unsuccessful")

            } else if user!.isNew {

                self.loginCompleted()

            } else {

                self.loginCompleted()

            }

        }

    }

    func loginCompleted() {

        self.activityIndicator.stopAnimating()
        self.translucentView?.removeFromSuperview()
        UdacityClient.sharedInstance.taskForGetMethod()
        self.performSegueWithIdentifier("segueToHome", sender: self)

    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "segueToHome" {

            ParseClient.sharedInstance.taskForGetMethod(100)

        }

    }


    @IBAction func signUpTapped(sender: AnyObject) {

        performSegueWithIdentifier("segueToUdacity", sender: self)

    }

    override func viewDidLoad() {

        super.viewDidLoad()
        emailField.delegate = self
        passwordField.delegate = self

        if (FBSDKAccessToken.currentAccessToken() != nil) {

            let token = FBSDKAccessToken.currentAccessToken()
            UdacityClient.sharedInstance.fbToken = token.tokenString
            self.getSessionID(1)

        } else {

            fbLoginButton.delegate = self
            fbLoginButton.readPermissions = self.permissions

        }

    }

    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {

        if error != nil {

            self.displayAlertView("Something's wrong...")

        } else {

            if FBSDKAccessToken.currentAccessToken() != nil {

                UdacityClient.sharedInstance.fbToken = FBSDKAccessToken.currentAccessToken().tokenString
                self.getSessionID(1)

            }

        }

    }

    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {

        println("User Logged Out")

    }

    override func viewWillAppear(animated: Bool) {

        super.viewWillAppear(animated)
        self.emailField.text = nil
        self.passwordField.text = nil
        subscribeToKeyboardNotification()

    }

    override func viewWillDisappear(animated: Bool) {

        super.viewWillDisappear(animated)
        unsubscribeToKeyboardNotification()

    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {

        textField.resignFirstResponder()
        return true

    }

    func subscribeToKeyboardNotification() {

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)

    }

    func unsubscribeToKeyboardNotification() {

        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)

    }

    func keyboardWillShow(notification: NSNotification) {

        if UIDevice.currentDevice().orientation == .LandscapeLeft ||  UIDevice.currentDevice().orientation == .LandscapeRight {

            if self.emailField.isFirstResponder() {

                self.view.frame.origin.y = -getKeyboardHeight(notification) + 20

            } else {

                self.view.frame.origin.y = -getKeyboardHeight(notification)

            }

        }

    }

    func keyboardWillHide(notification: NSNotification) {

        self.view.frame.origin.y = CGFloat(0)

    }

    func getKeyboardHeight(notification: NSNotification) -> CGFloat {

        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height

    }
}

