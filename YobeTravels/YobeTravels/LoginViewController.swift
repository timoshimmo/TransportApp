//
//  LoginViewController.swift
//  YobeTravels
//
//  Created by MacBook Pro on 1/12/16.
//  Copyright © 2016 AJE AJE. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {
    
    @IBOutlet weak var lUsername: UITextField!
    @IBOutlet weak var lPassword: UITextField!
    
    var returnValue:NSDictionary!
    var resInt:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
        
        let logDefaults = NSUserDefaults.standardUserDefaults()
        logDefaults.setObject(false, forKey: "logged")
        logDefaults.synchronize()

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
    
    @IBAction func btnLogin(sender: AnyObject) {
        
        let username = lUsername.text;
        let userpass = lPassword.text;

        
        //let usersInfo:userInfo = userInfo()
        let parameterss = ["username": username!, "password": userpass!]
        
        if(username!.isEmpty || userpass!.isEmpty)
        {
            
            let regAlert = UIAlertController(title: "Empty Fields", message: "All fields are required", preferredStyle: UIAlertControllerStyle.Alert);
            
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil);
            
            regAlert.addAction(okAction);
            
            self.presentViewController(regAlert, animated: true, completion: nil);
            
        }
        
        else {
            
            
            let logDefaults = NSUserDefaults.standardUserDefaults()
            logDefaults.setObject(username, forKey: "sessionUser")
            logDefaults.synchronize()
            
            
            Alamofire.request(.POST, "http://macbooks-macbook-pro.local/webservices/getUsers.php", parameters: parameterss)
                
                .responseJSON { res in
                    switch res.result {
                    case .Success(let dfr):
                        self.returnValue = (dfr as? NSDictionary)!
                        self.resInt = self.returnValue.objectForKey("status") as! Int
                        print("\(self.returnValue.objectForKey("status") as! Int)")
                    case .Failure(let err):
                        print("Error \(err)")
                        
                        
                }
                    
                    if (self.resInt == 1) {
                        let next = self.storyboard?.instantiateViewControllerWithIdentifier("TabHomeController") as! UITabBarController
                        self.presentViewController(next, animated: true, completion: nil)
                        
                    }
                        
                    else if(self.resInt == 2) {
                        let errAlert = UIAlertController(title: "Invalid Login", message: "Invalid username/password", preferredStyle: UIAlertControllerStyle.Alert);
                        
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
