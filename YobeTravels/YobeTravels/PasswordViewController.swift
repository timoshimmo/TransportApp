//
//  PasswordViewController.swift
//  YobeTravels
//
//  Created by MacBook Pro on 13/05/2016.
//  Copyright © 2016 AJE AJE. All rights reserved.
//

import UIKit

class PasswordViewController: UIViewController {

    @IBOutlet var confirmPassword: UITextField!
    @IBOutlet var newPassword: UITextField!
    
    
    var passString : String!
    var usernameString: String = ""
    var getUserDetails:AnyObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    @IBAction func btnPasswordUpdate(sender: AnyObject) {
        
        if(newPassword.text?.characters.count < 6) {
            let regAlert = UIAlertController(title: "Incorrect Entry", message: "Your password must be more than 6 characters", preferredStyle: UIAlertControllerStyle.Alert);
            
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil);
            
            regAlert.addAction(okAction);
            
            self.presentViewController(regAlert, animated: true, completion: nil);
        }
        
        else {
        
        if(newPassword.text != confirmPassword.text) {
            let regAlert = UIAlertController(title: "Incorrect Entry", message: "Your new passwords are not the same. Try again!", preferredStyle: UIAlertControllerStyle.Alert);
            
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil);
            
            regAlert.addAction(okAction);
            
            self.presentViewController(regAlert, animated: true, completion: nil);
        }
            
        else {
            
            let UserInfo: userInfo = userInfo()
            UserInfo.userName = newPassword.text!
            
            let params = ["password":UserInfo.userName, "username":usernameString]
            
            ModelManager.getInstance().editPass(params) { responseObj, error in
                
                let statusCode = responseObj?.objectForKey("status") as! Int
                
                if (statusCode == 1) {
                    let regAlert = UIAlertController(title: "Success", message: "Password successfully updated!", preferredStyle: UIAlertControllerStyle.Alert);
                    
                    let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil);
                    
                    regAlert.addAction(okAction);
                    
                    self.presentViewController(regAlert, animated: true, completion: nil);
                }
                    
                else {
                    let errAlert = UIAlertController(title: "Error", message: "Error updating profile", preferredStyle: UIAlertControllerStyle.Alert);
                    
                    let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil);
                    
                    errAlert.addAction(okAction);
                    
                    self.presentViewController(errAlert, animated: true, completion: nil);
                    
                }
                
                
                }
            
            }
            
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
