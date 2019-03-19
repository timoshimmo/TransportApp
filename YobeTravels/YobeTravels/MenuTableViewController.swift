//
//  MenuTableViewController.swift
//  YobeTravels
//
//  Created by MacBook Pro on 09/05/2016.
//  Copyright © 2016 AJE AJE. All rights reserved.
//

import UIKit

class MenuTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var menuTableView: UITableView!
    
    let sections = ["Profile Settings", ""]
    
    let items = [["Profile", "Change Password"], ["Logout"]]
    
    let images = [[UIImage(named: "PROFILE"), UIImage(named: "Career-Counceling")], [UIImage(named: "Logout")]]


    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        menuTableView.delegate = self
        menuTableView.dataSource = self
        
        self.menuTableView.tableFooterView = UIView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    func tableView(menuTableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionCell = menuTableView.dequeueReusableCellWithIdentifier("menuTitleCell") as! MenuTitleTableViewCell
        
        sectionCell.contentView.backgroundColor = hexStringToUIColor("#EBF0F9")
        
        sectionCell.menuTitle.text = self.sections[section]
        
        return sectionCell
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if(section == 2) {
            return 15
        }
        else {
            return 40
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 50
    }
   

    func numberOfSectionsInTableView(menuTableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.sections.count
    }

    func tableView(menuTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       return self.items[section].count
    }

    
    func tableView(menuTableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = menuTableView.dequeueReusableCellWithIdentifier("tableCell", forIndexPath: indexPath) as! MenuTableViewCell

        // Configure the cell...
        
        cell.menuString.text = self.items[indexPath.section][indexPath.row]
        cell.menuImage.image = self.images[indexPath.section][indexPath.row]

        return cell
    }
    
     func tableView(menuTableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let rowValue = self.items[indexPath.section][indexPath.row] as String!
        
        if( rowValue == "Profile") {
            
            let next = self.storyboard?.instantiateViewControllerWithIdentifier("ProfileView") as! ProfileViewController
            self.presentViewController(next, animated: true, completion: nil)
        }
        
        if(rowValue == "Change Password") {
            
            
            let next = self.storyboard?.instantiateViewControllerWithIdentifier("ChangePassViewController") as! PasswordViewController
            self.presentViewController(next, animated: true, completion: nil)
            
        }
        
        if(rowValue == "Logout") {
            
            
            let next = self.storyboard?.instantiateViewControllerWithIdentifier("LoginController") as! LoginViewController
            self.presentViewController(next, animated: true, completion: nil)
            
        }
        
        
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
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = cString.substringFromIndex(cString.startIndex.advancedBy(1))
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.grayColor()
        }
        
        var rgbValue:UInt32 = 0
        NSScanner(string: cString).scanHexInt(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

}
