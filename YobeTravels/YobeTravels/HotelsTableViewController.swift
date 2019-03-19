//
//  HotelsTableViewController.swift
//  YobeTravels
//
//  Created by MacBook Pro on 09/07/2016.
//  Copyright © 2016 AJE AJE. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HotelsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var hotelTableView: UITableView!
    
    var hotelArrays: AnyObject!
    let hotels: hotelsInfo = hotelsInfo()
    
    var disountValue: String!
    var hotelsLocation: String!
    let encodedHotelImages: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        hotelTableView.delegate = self
        hotelTableView.dataSource = self
        
        self.hotelTableView.tableFooterView = UIView()
        
    }
    
    func postHotelRequest() {
        
        let manager = Manager.sharedInstance
        // Specifying the Headers we need
        manager.session.configuration.HTTPAdditionalHeaders = [
            "Content-Type": "application/x-www-form-urlencoded"]
        
        let params = ["state" : self.hotelsLocation]
        
        Alamofire.request(.POST, "http://macbooks-macbook-pro.local/webservices/getHotels.php", parameters: params)
            
            .responseJSON { res in
                
                switch res.result {
                case .Success(let dfr):
                    self.hotelArrays = dfr as? [[String:AnyObject]]
                    self.hotels.rowCount = self.hotelArrays.count
                    self.hotelTableView.reloadData()
                    print("Hotel Data \(dfr)")
                case .Failure(let err):
                    print("Error in response : \(err)")
                }
                
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(hotelTableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(hotelTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.hotels.rowCount
    }

    
    func tableView(hotelTableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = hotelTableView.dequeueReusableCellWithIdentifier("hotelCell", forIndexPath: indexPath) as! HotelsTableViewCell

        hotels.hotelName = self.hotelArrays.objectAtIndex(indexPath.row).objectForKey("name")! as! String
        
        hotels.state = self.hotelArrays.objectAtIndex(indexPath.row).objectForKey("state")! as! String
        
        hotels.hotelImage = self.hotelArrays.objectAtIndex(indexPath.row).objectForKey("image_icon")! as! String
        
        hotels.weblink = self.hotelArrays.objectAtIndex(indexPath.row).objectForKey("links")! as! String
        
        imageBytes = self.hotels.hotelImage as String!
        
        let encodedImageString = imageBytes.dataUsingEncoding(NSUTF8StringEncoding)
        let imageData = NSData(base64EncodedString: encodedImageString, options: NSDataBase64DecodingOptions(rawValue: 0))
        
        var decodedImage = UIImage(data: imageData)
        
        cell.hotelName.text! = self.hotels.hotelName
        
        cell.hotelState.text! = self.hotels.state
        
        cell.imgHotel.image! = decodedImage
        
        cell.promoDesc.text! = "Get " + "" + "on any room you book. You will have to show your booking details at our counter to enjoy the discount"
        

        return cell
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
