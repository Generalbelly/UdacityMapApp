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
            getSessionID(UdacityClient.LoginMethod.Normal)
        default:
            break

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

        dispatch_async(dispatch_get_main_queue()) {

            self.presentViewController(alertController, animated: true, completion: nil)

        }

    }



    func getSessionID(m: UdacityClient.LoginMethod) {

        UdacityClient.sharedInstance.taskForPostMethod(m) { (success: Bool, res: Int?, error: NSError?) -> Void in

            switch success {

            case false:

                self.displayError(success, res: res, error:error)

            case true:

                self.chooseLoginMethod(m)

            default:
                break

            }

        }
        while UdacityClient.sharedInstance.sessionId == nil {

            if self.activityIndicator.isAnimating() == false {

                self.translucentView = UIView(frame: self.view.frame)
                self.translucentView!.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.5)
                self.view.addSubview(self.translucentView!)
                self.activityIndicator.hidden = false
                self.activityIndicator.startAnimating()

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

    func chooseLoginMethod(m: UdacityClient.LoginMethod) {

        if m == .Normal {

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
                self.removeAivandTv()

            } else if user!.isNew {

                self.loginCompleted()

            } else {

                self.loginCompleted()

            }

        }

    }

    func loginCompleted() {

        removeAivandTv()
        UdacityClient.sharedInstance.taskForGetMethod() { (success: Bool, res: Int?, error: NSError?) -> Void in

            switch success {

            case false:

                self.displayError(success, res: res, error:error)

            case true:

                dispatch_async(dispatch_get_main_queue()) {

                    self.performSegueWithIdentifier("segueToHome", sender: self)

                }

            default:
                break

            }


        }

    }

    func removeAivandTv() {

        activityIndicator.stopAnimating()
        translucentView?.removeFromSuperview()

    }

    @IBAction func signUpTapped(sender: AnyObject) {

        let app = UIApplication.sharedApplication()
        app.openURL(NSURL(string: UdacityClient.Constants.UdacityURL)!)

    }

    override func viewDidLoad() {

        super.viewDidLoad()
        emailField.delegate = self
        passwordField.delegate = self

        if (FBSDKAccessToken.currentAccessToken() != nil) {

            let token = FBSDKAccessToken.currentAccessToken()
            UdacityClient.sharedInstance.fbToken = token.tokenString
            self.getSessionID(UdacityClient.LoginMethod.Facebook)

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
                self.getSessionID(UdacityClient.LoginMethod.Facebook)

            }

        }

    }

    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {

        println("User Logged Out")

    }

    override func viewWillAppear(animated: Bool) {

        super.viewWillAppear(animated)
        emailField.text = nil
        passwordField.text = nil
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

