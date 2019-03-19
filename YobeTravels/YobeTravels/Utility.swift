//
//  Utility.swift
//  YobeTravels
//
//  Created by MacBook Pro on 3/7/16.
//  Copyright © 2016 AJE AJE. All rights reserved.
//

import UIKit

class Utility: NSObject {
    
    class func getPath(fileName: String) -> String {
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        let fileURL = documentsURL.URLByAppendingPathComponent(fileName)
        return fileURL.path!
    }

    class func copyFile(fileName: NSString) {
        let dbPath: String = getPath(fileName as String)
        let fileManager = NSFileManager.defaultManager()
        
        if !fileManager.fileExistsAtPath(dbPath) {
            let documentsURL = NSBundle.mainBundle().resourceURL
            let fromPath = documentsURL!.URLByAppendingPathComponent(fileName as String)
            var error : NSError?
            do {
                try fileManager.copyItemAtPath(fromPath.path!, toPath: dbPath)
            } catch let error1 as NSError {
                error = error1
            }
            let alert: UIAlertView = UIAlertView()
            if (error != nil) {
                alert.title = "Error Occured in copying database"
                alert.message = error?.localizedDescription

            }
            
            alert.delegate = nil
            alert.addButtonWithTitle("Ok")
            alert.show()
        
        }
    }
    
    class func invokeAlertMethod(targetVC : UIViewController, strTitle: NSString, strBody: NSString)
    {
        
        let alert = UIAlertController(title: strTitle as String, message: strBody as String, preferredStyle: UIAlertControllerStyle.Alert);
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil);
        
        alert.addAction(okAction);
        
        targetVC.presentViewController(alert, animated: true, completion: nil);

    }

}
