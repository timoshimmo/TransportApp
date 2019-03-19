//
//  SignUpViewController.swift
//  YobeTravels
//
//  Created by MacBook Pro on 3/7/16.
//  Copyright © 2016 AJE AJE. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var sUsername: UITextField!
    @IBOutlet weak var sPassword: UITextField!
    @IBOutlet weak var sEmail: UITextField!
    @IBOutlet weak var sMobile: UITextField!
    
     var userData : userInfo!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSignUp(sender: AnyObject) {
        
        let username = sUsername.text;
        let userpass = sPassword.text;
        let emailAdd = sEmail.text;
        let mobileNum = sMobile.text;
    
        if(username!.isEmpty || userpass!.isEmpty || emailAdd!.isEmpty || mobileNum!.isEmpty) {
            
            let regAlert = UIAlertController(title: "Error", message: "All fields are required", preferredStyle: UIAlertControllerStyle.Alert);
            
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil);
            
            regAlert.addAction(okAction);
            
            self.presentViewController(regAlert, animated: true, completion: nil);
            
        }
        
        else {
            
            let UserInfo: userInfo = userInfo()
            UserInfo.userName = username!
            UserInfo.passWord = userpass!
            UserInfo.emailAddress = emailAdd!
            UserInfo.mobileNo = mobileNum!
            
            
            let data = ["username": UserInfo.userName, "password": UserInfo.passWord, "email": UserInfo.emailAddress,
                                  "mobile": UserInfo.mobileNo]
            
            ModelManager.getInstance().addNewUser(data) { responseObj, error in
                
                let response = responseObj?.objectForKey("status") as? Int
                
                if (response == 1) {
                    let next = self.storyboard?.instantiateViewControllerWithIdentifier("LoginController") as! LoginViewController
                    self.presentViewController(next, animated: true, completion: nil)
                    
                } else if(response == 0) {
                    let errAlert = UIAlertController(title: "Error", message: "Error inserting data", preferredStyle: UIAlertControllerStyle.Alert);
                    
                    let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil);
                    
                    errAlert.addAction(okAction);
                    
                    self.presentViewController(errAlert, animated: true, completion: nil);
                }
                
                else {
                    let errAlert = UIAlertController(title: "Error", message: "No Internet Connection is available!", preferredStyle: UIAlertControllerStyle.Alert);
                    
                    let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil);
                    
                    errAlert.addAction(okAction);
                    
                    self.presentViewController(errAlert, animated: true, completion: nil);

                }
                
                print("\(responseObj?.objectForKey("status")) \n \(error) ")
                
            }
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
