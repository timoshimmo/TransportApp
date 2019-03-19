//
//  ResultsTableViewController.swift
//  YobeTravels
//
//  Created by MacBook Pro on 13/05/2016.
//  Copyright © 2016 AJE AJE. All rights reserved.
//

import UIKit

class ResultsTableViewController: UITableViewController {
    
    var searchResultsArray : AnyObject!
    
    var busCompany: String!
    var destination: String!
    var from: String!
    var dateTime: String!
    var price: String!
    var station: String!
    
    var travelss:travelsInfo = travelsInfo()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
       // tableView.contentInset = UIEdgeInsetsMake(30, 0, 0, 0);
        
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
        return searchResultsArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MemSearchResult", forIndexPath: indexPath) as! MemberTableViewCell
        
        self.travelss.busCompany = self.searchResultsArray.objectAtIndex(indexPath.row).objectForKey("bus_company")! as! String
        
        self.travelss.station = self.searchResultsArray.objectAtIndex(indexPath.row).objectForKey("station")! as! String
        
        self.travelss.price = self.searchResultsArray.objectAtIndex(indexPath.row).objectForKey("price")! as! String
        
        self.travelss.departureDate = self.searchResultsArray.objectAtIndex(indexPath.row).objectForKey("departure_date")! as! String
        self.travelss.departureTime = self.searchResultsArray.objectAtIndex(indexPath.row).objectForKey("departure_time")! as! String
        
        self.travelss.from = self.searchResultsArray.objectAtIndex(indexPath.row).objectForKey("departure")! as! String
        
        self.travelss.destination = self.searchResultsArray.objectAtIndex(indexPath.row).objectForKey("destination")! as! String
        
        cell.memBusCompany.text = travelss.busCompany
        cell.memStation.text = travelss.station
        cell.memPrice.text = travelss.price
        cell.memDateTime.text = travelss.departureDate + " " + travelss.departureTime
        cell.memDestination.text! = travelss.from + "-" + travelss.destination

        // Configure the cell...

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
         let cell = tableView.dequeueReusableCellWithIdentifier("MemSearchResult", forIndexPath: indexPath) as! MemberTableViewCell
        
        travelss.busCompany = cell.memBusCompany.text!
        travelss.station = cell.memStation.text!
        travelss.price = cell.memPrice.text!
        dateTime = cell.memDateTime.text!
        //travelss.destination = cell.memDestination.text!
        
        self.performSegueWithIdentifier("resultSegue", sender: self)
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 60
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.  
        
        if(segue.identifier == "resultSegue") {
        
            let bvc = segue.destinationViewController as! BookingViewController
            
            //let cell = sender as! MemberTableViewCell
            //let selectedRow = tableView.indexPathForCell(cell)!.row
            
            busCompany = travelss.busCompany
            destination = travelss.destination
            from = travelss.from
            dateTime = travelss.departureDate + " " + travelss.departureTime
            station = travelss.station
            price = travelss.price
        
            bvc.busComp = busCompany
            bvc.destn = destination
            bvc.from = from
            bvc.dTime = dateTime
            bvc.stn = station
            bvc.pr = price
            
        }
        
    }
 

}
