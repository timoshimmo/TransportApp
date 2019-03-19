//
//  SearchViewController.swift
//  YobeTravels
//
//  Created by MacBook Pro on 28/05/2016.
//  Copyright © 2016 AJE AJE. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UIPickerViewDataSource, UITextFieldDelegate, UIPickerViewDelegate {
    
    var popDatePicker : PopDatePicker?

    @IBOutlet weak var textDeparture: UITextField!
    @IBOutlet weak var textDestination: UITextField!
    
    @IBOutlet weak var textDepDate: UITextField!
    var locationsPicker: UIPickerView! = UIPickerView()
    
    
    var travelArrays: AnyObject!
    var locationsArray: AnyObject!
    
    var loadTravels = false
    var countArray:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        popDatePicker = PopDatePicker(forTextField: textDepDate)
        textDepDate.delegate = self
        textDeparture.delegate = self
        textDestination.delegate = self
        
        locationsPicker.delegate = self
        locationsPicker.dataSource = self
        
        getAllLocations()
        
        textDeparture.inputView = locationsPicker
        textDestination.inputView = locationsPicker

    }
    
    func resign() {
        
        textDepDate.resignFirstResponder()
        textDestination.resignFirstResponder()
        textDeparture.resignFirstResponder()
    }
    
    func getAllLocations() {
        
        ModelManager.getInstance().travelLocations() { responseObj, error in
            
            self.locationsArray = responseObj
            print("Response: \(self.locationsArray)")
            
        }
    }
    
     func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        if (textField === textDepDate) {
            resign()
            let formatter = NSDateFormatter()
            formatter.dateStyle = .MediumStyle
            formatter.timeStyle = .NoStyle
            let initDate : NSDate? = formatter.dateFromString(textDepDate.text!)
            
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
        
        if (identifier == "memSearchSegue") {
            
            let destination = textDestination.text;
            let dpDate = textDepDate.text;
            let dpStation = textDeparture.text;
            
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
                                self.performSegueWithIdentifier("memSearchSegue", sender: self)
                                
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
        if(textDeparture.editing) {
            return textDeparture.text = self.locationsArray.objectAtIndex(row).objectForKey("states") as? String
        }
            
        else if(textDestination.editing) {
            return textDestination.text = self.locationsArray.objectAtIndex(row).objectForKey("states") as? String
        }
    }

    
    @IBAction func btnSearch(sender: AnyObject) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if(segue.identifier == "memSearchSegue") {
            
           let svc = segue.destinationViewController as! ResultsTableViewController
           svc.searchResultsArray = self.travelArrays
            
        }
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
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
