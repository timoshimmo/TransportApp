//
//  ProfileViewController.swift
//  YobeTravels
//
//  Created by MacBook Pro on 13/05/2016.
//  Copyright © 2016 AJE AJE. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var usernameString: String=""
    
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtUsername: UITextField!
    @IBOutlet var txtMobile: UITextField!
    
    var getUserDetails:AnyObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let loggedUser: AnyObject
        
        loggedUser = NSUserDefaults.standardUserDefaults().objectForKey("sessionUser")!
        
        usernameString = loggedUser as! String
        
        //usernameString = "userexample"
        
        let params = ["username":usernameString]
        
        ModelManager.getInstance().getUserData(params) { responseObj, error in
            
            self.getUserDetails = responseObj
            
            self.txtUsername.text = self.usernameString
            self.txtEmail.text = self.getUserDetails.objectAtIndex(0).objectForKey("email") as? String
            self.txtMobile.text = self.getUserDetails.objectAtIndex(0).objectForKey("mobile") as? String
            
        }
        
    }
    
    
    
    @IBAction func btnUpdateUsers(sender: AnyObject) {
        
        if(txtEmail.text!.isEmpty || txtUsername.text!.isEmpty || txtMobile.text!.isEmpty) {
            
            let errAlert = UIAlertController(title: "Empty Fields", message: "All fields are required to be filled!", preferredStyle: UIAlertControllerStyle.Alert);
            
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil);
            
            errAlert.addAction(okAction);
            
            self.presentViewController(errAlert, animated: true, completion: nil);
            
        }
        
        else {
            
            let UserInfo: userInfo = userInfo()
            UserInfo.userName = txtUsername.text!
            UserInfo.emailAddress = txtEmail.text!
            UserInfo.mobileNo = txtMobile.text!
            
            let params = ["username":UserInfo.userName, "email": UserInfo.emailAddress, "mobile":UserInfo.mobileNo, "usersname":usernameString]
            
            ModelManager.getInstance().editUsers(params) { responseObj, error in
                
                let statusCode = responseObj?.objectForKey("status") as! Int
                
                if (statusCode == 1) {
                    let regAlert = UIAlertController(title: "Success", message: "Profile successfully updated!", preferredStyle: UIAlertControllerStyle.Alert);
                    
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
