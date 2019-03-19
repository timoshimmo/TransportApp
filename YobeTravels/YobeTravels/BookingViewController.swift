 //
//  BookingViewController.swift
//  YobeTravels
//
//  Created by MacBook Pro on 28/05/2016.
//  Copyright © 2016 AJE AJE. All rights reserved.
//

import UIKit
import Foundation
import MessageUI

class BookingViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    var busComp: String!
    var destn: String!
    var from: String!
    var dTime: String!
    var pr: String!
    var stn: String!
    
    var usernameString: String!
    
    var returnValue:AnyObject!

    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblBusComp: UILabel!
    @IBOutlet weak var lblTrip: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lbldateTime: UILabel!
    @IBOutlet weak var txtPromoCode: UITextField!
    @IBOutlet weak var lblStation: UILabel!
    
    var txtName: UITextField?
    var txtPhone: UITextField?
    var txtEmail: UITextField?
    
    let BookingInfo: bookingInfo = bookingInfo()
    let PromoInfo: promoInfo = promoInfo()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BookingViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        let loggedUser: AnyObject
        loggedUser = NSUserDefaults.standardUserDefaults().objectForKey("sessionUser")!
        
        usernameString = loggedUser as! String
        
        lblUsername.text = usernameString
        lblBusComp.text = busComp
        lblTrip.text = from + " - " + destn
        lblPrice.text = pr
        lbldateTime.text = dTime
        lblStation.text = stn
        
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    @IBAction func btnBooking(sender: AnyObject) {
        
        
        BookingInfo.username = lblUsername.text!
        BookingInfo.busCompany = lblBusComp.text!
        BookingInfo.from = from
        BookingInfo.trip = destn
        BookingInfo.datetime = lbldateTime.text!
        BookingInfo.station = lblStation.text!
        
        let bookingPrice:Double = Double(lblPrice.text!)!
        
        BookingInfo.price = bookingPrice
        
        let alertController = UIAlertController(title: "Guardian Contact", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        
        let saveAction = UIAlertAction(title: "Confirm", style: UIAlertActionStyle.Default, handler: {
            alert -> Void in
            
            let nameTextField = alertController.textFields![0] as UITextField
            let phoneTextField = alertController.textFields![1] as UITextField
            let emailTextField = alertController.textFields![2] as UITextField
            
            let namess = nameTextField.text
            let mobiless = phoneTextField.text
            let emailss = emailTextField.text
            
             print("Recipient Name: \(namess) \n Mobile: \(mobiless) \n Email: \(emailss)")
            
            self.BookingInfo.recipientName = namess as! String
            self.BookingInfo.recipientMobile = mobiless as! String
            self.BookingInfo.recipientEmail = emailss as! String
            
        let paramssss = ["username":self.BookingInfo.username, "bus":self.BookingInfo.busCompany, "from":self.BookingInfo.from ,"to":self.BookingInfo.trip, "datetime":self.BookingInfo.datetime, "price":self.lblPrice.text!, "promocode":self.BookingInfo.promoCode, "station":self.BookingInfo.station]
            
            if(self.txtPromoCode.text!.isEmpty) {
                
                self.BookingInfo.promoCode = "none"
                
                
                ModelManager.getInstance().addNewBooking(paramssss) { responseObj, error in
                    
                    
                    let statusCode = responseObj?.objectForKey("status") as! Int
                    
                    
                    if (statusCode == 1) {
                        let mailComposeViewController = self.configuredMailComposeViewController()
                        if MFMailComposeViewController.canSendMail() {
                            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
                        } else {
                            self.showSendMailErrorAlert()
                        }
                    }
                        
                    else {
                        
                        let errAlert = UIAlertController(title: "Error", message: "Error inserting data", preferredStyle: UIAlertControllerStyle.Alert);
                        
                        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil);
                        
                        errAlert.addAction(okAction);
                        
                        self.presentViewController(errAlert, animated: true, completion: nil);
                        
                    }

                    
                }
                
                
            }
                
            else {
                
                let paramsss = ["busCompany":self.BookingInfo.busCompany, "promoCode":self.txtPromoCode.text!]
                
                ModelManager.getInstance().getPromoCode(paramsss) { responseObj, error in
                    
                    self.returnValue = responseObj
                    
                    print("Promo Data: \(responseObj)")
                    print("Promo List: \(self.returnValue)")
                    
                    if (self.returnValue != nil && self.returnValue.count > 0) {
                        self.BookingInfo.promoCode = self.txtPromoCode.text!
                        
                        
                        let prVal = self.returnValue.objectAtIndex(0).objectForKey("promo_value") as! String
                        
                        self.PromoInfo.discount = prVal
                        
                        let promoValue:Int! = Int(self.PromoInfo.discount)
                        let bkPrice:Int! = Int(self.BookingInfo.price)
                        
                        let calcPrice:Int? = bkPrice - promoValue * 1 * bkPrice / 100
                        let newPrice:Double! = Double(calcPrice!)
                        
                        self.BookingInfo.price = newPrice
                        
                        ModelManager.getInstance().addNewBooking(paramssss) { responseObj, error in
                            
                            let statusCode = responseObj?.objectForKey("status") as! Int
                            
                            if (statusCode == 1) {
                                let mailComposeViewController = self.configuredPromoMailComposeViewController()
                                if MFMailComposeViewController.canSendMail() {
                                    self.presentViewController(mailComposeViewController, animated: true, completion: nil)
                                } else {
                                    self.showSendMailErrorAlert()
                                }
                            }
                                
                            else {
                                
                                let errAlert = UIAlertController(title: "Error", message: "Error inserting data", preferredStyle: UIAlertControllerStyle.Alert);
                                
                                let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil);
                                
                                errAlert.addAction(okAction);
                                
                                self.presentViewController(errAlert, animated: true, completion: nil);
                                
                            }
                            
                        }
                        
                        
                    }
                        
                    else {
                        
                        let errAlert = UIAlertController(title: "Error", message: "Wrong Promo Code. Check your promo code and try again", preferredStyle: UIAlertControllerStyle.Alert);
                        
                        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil);
                        
                        errAlert.addAction(okAction);
                        
                        self.presentViewController(errAlert, animated: true, completion: nil);
                        
                    }
                    
                }
                
            }
            
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: {
            (action : UIAlertAction!) -> Void in
            
        })
        
        alertController.addTextFieldWithConfigurationHandler { (textField : UITextField!) -> Void in
            
            textField.placeholder = "Name"
            self.txtName = textField
           
        }
        alertController.addTextFieldWithConfigurationHandler { (textField : UITextField!) -> Void in
            
            textField.placeholder = "Mobile Number"
            textField.keyboardType = UIKeyboardType.PhonePad
            self.txtPhone = textField
            
        }
        
        alertController.addTextFieldWithConfigurationHandler { (textField : UITextField!) -> Void in
            
            textField.placeholder = "Email"
            textField.keyboardType = UIKeyboardType.EmailAddress
            self.txtEmail = textField
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
        
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        let bookingMessage:String = "Username : \(BookingInfo.username) \n Bus : \(BookingInfo.busCompany) \n Trip : Yobe - \(BookingInfo.trip) \n Price : \(BookingInfo.price) \n Date: \(BookingInfo.datetime) \n Station : \(BookingInfo.station ) \n Guardian Name: \(BookingInfo.recipientName) \n Guardian Mobile: \(BookingInfo.recipientMobile) \n Guardian Email: \(BookingInfo.recipientEmail)"
        
        
        mailComposerVC.setToRecipients(["ajeaje@live.com", BookingInfo.recipientEmail])
        mailComposerVC.setSubject("Booking")
        mailComposerVC.setMessageBody(bookingMessage, isHTML: false)
        
        return mailComposerVC
        
    }
    
    func configuredPromoMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        let bookingMessage:String = "Username : \(BookingInfo.username) \n Bus : \(BookingInfo.busCompany) \n Trip : Yobe - \(BookingInfo.trip) \n" + "Discounted Price : \(BookingInfo.price) \n Date: \(BookingInfo.datetime) \n Station : \(BookingInfo.station) \n Promo Code : \(BookingInfo.promoCode) \n Guardian Name: \(BookingInfo.recipientName) \n Guardian Mobile: \(BookingInfo.recipientMobile) \n Guardian Email: \(BookingInfo.recipientEmail) \n \n Congratulations you just received a discount value of \(PromoInfo.discount)%"
        
        
        mailComposerVC.setToRecipients(["ajeaje@live.com", BookingInfo.recipientEmail])
        mailComposerVC.setSubject("Booking")
        mailComposerVC.setMessageBody(bookingMessage, isHTML: false)
        
        return mailComposerVC
    }

    
    
    func showSendMailErrorAlert() {
        
        let sendMailErrorAlert = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", preferredStyle: UIAlertControllerStyle.Alert);
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil);
        
        sendMailErrorAlert.addAction(okAction);
        
        self.presentViewController(sendMailErrorAlert, animated: true, completion: nil);
               
    }
    
    // MARK: MFMailComposeViewControllerDelegate
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        
        controller.dismissViewControllerAnimated(true, completion: nil)
        
        if(result == MFMailComposeResultCancelled || result == MFMailComposeResultSent) {
            
            switch(result) {
                
            case MFMailComposeResultCancelled:
                print("Message was cancelled!")
                
                break;
                
            case MFMailComposeResultSent:
                let regAlert = UIAlertController(title: "Booking Successful", message: "Booking Confirmation Sent. Check your mail to receive more details of your booking", preferredStyle: UIAlertControllerStyle.Alert);
                
                let BookingActionHandler = { (action:UIAlertAction!) -> Void in
                    let next = self.storyboard?.instantiateViewControllerWithIdentifier("TabHomeController") as! UITabBarController
                    self.presentViewController(next, animated: true, completion: nil)
                }
                
                
                let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: BookingActionHandler);
                
                regAlert.addAction(okAction);
                
                self.presentViewController(regAlert, animated: true, completion: nil);
                
                break;
                
                
            default:
                break;
                
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
