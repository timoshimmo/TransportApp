//
//  TravelListTableViewController.swift
//  YobeTravels
//
//  Created by MacBook Pro on 1/12/16.
//  Copyright © 2016 AJE AJE. All rights reserved.
//

import UIKit

class TravelListTableViewController: UITableViewController {
    
    var travelData: AnyObject!
    var travelss:travelsInfo = travelsInfo()
    
    var countList: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.tableFooterView = UIView()
        
        self.tableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return countList
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("travelsCell", forIndexPath: indexPath) as! NonMemberCell

        //travelss = travelData.objectAtIndex(indexPath.row) as! travelsInfo
        
        self.travelss.busCompany = self.travelData.objectAtIndex(indexPath.row).objectForKey("bus_company")! as! String
        self.travelss.station = self.travelData.objectAtIndex(indexPath.row).objectForKey("station")! as! String
        
        self.travelss.price = self.travelData.objectAtIndex(indexPath.row).objectForKey("price")! as! String
        
        self.travelss.departureDate = self.travelData.objectAtIndex(indexPath.row).objectForKey("departure_date")! as! String
        self.travelss.departureTime = self.travelData.objectAtIndex(indexPath.row).objectForKey("departure_time")! as! String
        
        let priceString = String(self.travelss.price)
        
        cell.busCompany.text = travelss.busCompany
        cell.lblStation.text = travelss.station
        cell.lblPrice.text = "\(priceString) NGN"
        cell.lblTime.text = travelss.departureDate + " " + travelss.departureTime
        
        // Configure the cell...

        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let regAlert = UIAlertController(title: "Sign Up for More", message: "Sign Up to get the full features of the app", preferredStyle: UIAlertControllerStyle.Alert);
        
        let SignupActionHandler = { (action:UIAlertAction!) -> Void in
            let next = self.storyboard?.instantiateViewControllerWithIdentifier("SignUpController") as! SignUpViewController
            self.presentViewController(next, animated: true, completion: nil)
        }
        
        let okAction = UIAlertAction(title: "Sign Up", style: UIAlertActionStyle.Default, handler: SignupActionHandler);
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil);
        
        regAlert.addAction(okAction);
        regAlert.addAction(cancelAction);
        
        self.presentViewController(regAlert, animated: true, completion: nil);
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
