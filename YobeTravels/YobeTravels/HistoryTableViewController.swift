//
//  HistoryTableViewController.swift
//  YobeTravels
//
//  Created by MacBook Pro on 28/05/2016.
//  Copyright © 2016 AJE AJE. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HistoryTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var historyTable: UITableView!
    
    var getBookingDetails:AnyObject!
    let BookingInfo: bookingInfo = bookingInfo()
    
    var loggedUser: AnyObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        historyTable.delegate = self
        historyTable.dataSource = self
            
        postBookingRequest()
        
        self.historyTable.tableFooterView = UIView()
        
        
    }
    
    func postBookingRequest() {
        
        let manager = Manager.sharedInstance
        // Specifying the Headers we need
        manager.session.configuration.HTTPAdditionalHeaders = [
            "Content-Type": "application/x-www-form-urlencoded"]
        
        self.loggedUser = NSUserDefaults.standardUserDefaults().objectForKey("sessionUser")!
        let params = ["username": self.loggedUser as! String]

        
        Alamofire.request(.POST, "http://macbooks-macbook-pro.local/webservices/getBooking.php", parameters: params)
            
            .responseJSON { res in
                
                switch res.result {
                case .Success(let list):
                    
                    self.getBookingDetails = list as? [[String:AnyObject]]
                    self.BookingInfo.bookingCount = self.getBookingDetails.count
                    
                    let vw = self.view.viewWithTag(101)
                    
                    if (self.getBookingDetails != nil) {
                        vw!.hidden = true
                    }
                    else {
                        self.historyTable.hidden = true
                    }
                    
                    print("History : \(self.getBookingDetails)")
                    self.historyTable.reloadData()
                    
                case .Failure(let error):
                    print("Error in response : \(error)")
                }
                
        }
        
    }

    
    func numberOfSectionsInTableView(historyTable: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(historyTable: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.BookingInfo.bookingCount
    }
    
    func tableView(historyTable: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
         let cell = historyTable.dequeueReusableCellWithIdentifier("historyCell", forIndexPath: indexPath) as! HistoryTableViewCell
        
        self.BookingInfo.busCompany = self.getBookingDetails.objectAtIndex(indexPath.row).objectForKey("bus_company")! as! String
        
        self.BookingInfo.trip = self.getBookingDetails.objectAtIndex(indexPath.row).objectForKey("trip")! as! String
        
        self.BookingInfo.datetime = self.getBookingDetails.objectAtIndex(indexPath.row).objectForKey("date_time")! as! String
        
        
        cell.lblBusCompany.text! = self.BookingInfo.busCompany
        cell.lblPrice.text! = self.getBookingDetails.objectAtIndex(indexPath.row).objectForKey("price")! as! String
        cell.lblTrip.text! = self.BookingInfo.trip
        cell.lblDate.text! = self.BookingInfo.datetime
        
        return cell
        
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
