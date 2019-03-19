//
//  PromoTableViewController.swift
//  YobeTravels
//
//  Created by MacBook Pro on 13/05/2016.
//  Copyright © 2016 AJE AJE. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PromoTableViewController: UITableViewController {
    
    var promoArrays: AnyObject!
    let promo: promoInfo = promoInfo()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        //self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        postPromotionRequest()
        
        tableView.sizeToFit()
        tableView.estimatedRowHeight = tableView.rowHeight
        
        let logDefaults = NSUserDefaults.standardUserDefaults()
        logDefaults.setObject(true, forKey: "logged")
        logDefaults.synchronize()

    }
   
    
    func postPromotionRequest() {
        
        let manager = Manager.sharedInstance
        // Specifying the Headers we need
        manager.session.configuration.HTTPAdditionalHeaders = [
            "Content-Type": "application/x-www-form-urlencoded"]
        
        Alamofire.request(.POST, "http://macbooks-macbook-pro.local/webservices/getPromo.php")
            
            .responseJSON { res in
                
                switch res.result {
                case .Success(let list):
                    self.promoArrays = list as? [[String:AnyObject]]
                    self.promo.rowCount = self.promoArrays.count
                    self.tableView.reloadData()
                    
                case .Failure(let error):
                    print("Error in response : \(error)")
                }
                
        }
        
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
        return promo.rowCount
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCellWithIdentifier("promoCell", forIndexPath: indexPath) as! PromoTableViewCell
        
        self.promo.discount = self.promoArrays.objectAtIndex(indexPath.row).objectForKey("promo_value")! as! String
        self.promo.busCompany = self.promoArrays.objectAtIndex(indexPath.row).objectForKey("company_name")! as! String
        self.promo.tripFrom = self.promoArrays.objectAtIndex(indexPath.row).objectForKey("trip_from")! as! String
        self.promo.tripTo = self.promoArrays.objectAtIndex(indexPath.row).objectForKey("trip_to")! as! String
        self.promo.duration = self.promoArrays.objectAtIndex(indexPath.row).objectForKey("promo_duration")! as! String
        self.promo.additionalInfo = self.promoArrays.objectAtIndex(indexPath.row).objectForKey("additional_info")! as! String

        
        cell.discountValue.text = "\(self.promo.discount)% discount"
        cell.busComapny.text = self.promo.busCompany
        cell.destination.text = "\(self.promo.tripFrom) to \(self.promo.tripTo)"
        cell.promoDuration.text = self.promo.duration
        cell.addtionalInfo.text = self.promo.additionalInfo

        // Configure the cell...

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        /*let regAlert = UIAlertController(title: "Promo Code", message: "Follow the requirement in the promo information in order to get a promo code", preferredStyle: UIAlertControllerStyle.Alert);
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil);
        
        regAlert.addAction(okAction);
        
        self.presentViewController(regAlert, animated: true, completion: nil);*/
        
        self.performSegueWithIdentifier("hotelSegue", sender: self)
  
        
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if(segue.identifier == "hotelSegue") {
            
            let htc = segue.destinationViewController as! HotelsTableViewController
            
            htc.hotelsLocation = self.promo.tripTo
            htc.disountValue = "\(self.promo.discount)% discount"
        }

    }
    

}
