//
//  ViewController.swift
//  YobeTravels
//
//  Created by MacBook Pro on 11/24/15.
//  Copyright © 2015 AJE AJE. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UITextFieldDelegate, UIPickerViewDelegate {
    
     var popDatePicker : PopDatePicker?
    
    @IBOutlet weak var departureDate: UITextField!
    @IBOutlet weak var departure: UITextField!
    @IBOutlet weak var arrival: UITextField!
    var locationsPicker: UIPickerView! = UIPickerView()
    
    var travelArrays: AnyObject!
    var locationsArray: AnyObject!
    
    var loadTravels = false
    var countArray:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        popDatePicker = PopDatePicker(forTextField: departureDate)
        
        departureDate.delegate = self
        departure.delegate = self
        arrival.delegate = self
        
        locationsPicker.delegate = self
        locationsPicker.dataSource = self
        
        getAllLocations()
        
        departure.inputView = locationsPicker
        arrival.inputView = locationsPicker
            
    }
    
    func resign() {
        
        departureDate.resignFirstResponder()
        arrival.resignFirstResponder()
        departure.resignFirstResponder()
    }
    
    func getAllLocations() {
        
        ModelManager.getInstance().travelLocations() { responseObj, error in
            
            self.locationsArray = responseObj
            
        }
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        if (textField === departureDate) {
            resign()
            let formatter = NSDateFormatter()
            formatter.dateStyle = .MediumStyle
            formatter.timeStyle = .NoStyle
            let initDate : NSDate? = formatter.dateFromString(departureDate.text!)
            
            let dataChangedCallback : PopDatePicker.PopDatePickerCallback = { (newDate : NSDate, forTextField : UITextField) -> () in
                
                // here we don't use self (no retain cycle)
                forTextField.text = (newDate.ToDateMediumString() ?? "?") as String
                
            }
            
            popDatePicker!.pick(self, initDate: initDate, dataChanged: dataChangedCallback)
            return false
        }
        else {
            return true
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {

        if (identifier == "searchSegue") {
            
            let destination = arrival.text;
            let dpDate = departureDate.text;
            let dpStation = departure.text;
            
            let params = ["departure": dpStation!, "destination":destination!, "departureDate":dpDate!]
            
            
            if(destination!.isEmpty || dpDate!.isEmpty || dpStation!.isEmpty) {
                
                let regAlert = UIAlertController(title: "Empty Fields", message: "All fields are required", preferredStyle: UIAlertControllerStyle.Alert);
                
                let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil);
                
                regAlert.addAction(okAction);
                
                self.presentViewController(regAlert, animated: true, completion: nil);
                
            }
                
            else {
                
                if(!loadTravels) {
                    
                    ModelManager.getInstance().nonMemberList(params) { responseObj, error in
                        
                        self.travelArrays = responseObj
                        self.countArray = responseObj?.count
                        
                        print("Array : \(self.travelArrays)")
                        
                        if(self.countArray < 1) {
                            let regAlert = UIAlertController(title: "Empty Result", message: "No data found for this search. Change the location and departure date and try again!", preferredStyle: UIAlertControllerStyle.Alert);
                            
                            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil);
                            
                            regAlert.addAction(okAction);
                            
                            self.presentViewController(regAlert, animated: true, completion: nil);
                        }
                            
                        else {
                            
                            dispatch_async(dispatch_get_main_queue()){
                                
                                self.loadTravels = true
                                self.performSegueWithIdentifier("searchSegue", sender: self)
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
        return loadTravels
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.locationsArray.count
    }
    //MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.locationsArray.objectAtIndex(row).objectForKey("states") as? String
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(departure.editing) {
            return departure.text = self.locationsArray.objectAtIndex(row).objectForKey("states") as? String
        }
        
        else if(arrival.editing) {
            return arrival.text = self.locationsArray.objectAtIndex(row).objectForKey("states") as? String
        }
    }
    
    @IBAction func btnSearch(sender: AnyObject) {
        
        
    }
    
    @IBAction func btnSignUp(sender: AnyObject) {
        self.performSegueWithIdentifier("signupSegue", sender: self)
    }
    
    @IBAction func btnLogin(sender: AnyObject) {
        self.performSegueWithIdentifier("loginSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if (segue.identifier == "searchSegue") {
            
            let svc = segue.destinationViewController as! UINavigationController
            let nvc = svc.topViewController as! TravelListTableViewController
            nvc.travelData = self.travelArrays
            nvc.countList = self.countArray
            
        }
        
        if (segue.identifier == "signupSegue") {
            
            let next = self.storyboard?.instantiateViewControllerWithIdentifier("SignUpController") as! SignUpViewController
            self.presentViewController(next, animated: true, completion: nil)
            
        }
        
        if (segue.identifier == "loginSegue") {
            
            let next = self.storyboard?.instantiateViewControllerWithIdentifier("LoginController") as! LoginViewController
            self.presentViewController(next, animated: true, completion: nil)
            
        }
        
    }
    

    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

