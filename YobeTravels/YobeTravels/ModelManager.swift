//
//  ModelManager.swift
//  YobeTravels
//
//  Created by MacBook Pro on 3/7/16.
//  Copyright © 2016 AJE AJE. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON

let sharedInstance = ModelManager()

class ModelManager: NSObject {
    
    
    class func getInstance() -> ModelManager
    {
       return sharedInstance
    }

    func postAddUserRequest(urlString: String, params: [String:String], completionHandler: (NSDictionary?, NSError?) -> ()) {
        
        let manager = Manager.sharedInstance
        // Specifying the Headers we need
        manager.session.configuration.HTTPAdditionalHeaders = [
            "Content-Type": "application/x-www-form-urlencoded"]
        
        Alamofire.request(.POST, urlString, parameters: params)
            
            .responseJSON { res in
                switch res.result {
                case .Success(let dfr):
                    completionHandler(dfr as? NSDictionary, nil)
                    print("\(dfr)")
                case .Failure(let err):
                    completionHandler(nil, err)
                    
                }
            }
        
    }
    
    func addNewUser(parameterss: [String:String], completionHandler: (NSDictionary?, NSError?) -> ()) {
        
        self.postAddUserRequest("http://macbooks-macbook-pro.local/webservices/addUser.php", params: parameterss, completionHandler: completionHandler)
        
    }
    
    func authenUser(parameterss: [String:String], completionHandler: ([[String: AnyObject]]?, NSError?) -> ()) {
        
        self.postAuthRequest("http://macbooks-macbook-pro.local/webservices/getUsers.php", params: parameterss,completionHandler: completionHandler)
        
    }
    
    func postAuthRequest(urlString: String, params: [String:String], completionHandler: ([[String: AnyObject]]?, NSError?) -> ()) {
        
        Alamofire.request(.POST, urlString, parameters: params)
            
            .responseJSON { res in
                switch res.result {
                case .Success(let dfr):
                    completionHandler(dfr as? [[String:AnyObject]], nil)
                    print("Data \(dfr)")
                case .Failure(let err):
                    completionHandler(nil, err)
                    
                }
        }

    }
    
    func getPromoCode(parameterss: [String:String], completionHandler: ([[String: AnyObject]]?, NSError?) -> ()) {
        
        self.postgetPromoCode("http://macbooks-macbook-pro.local/webservices/getPromoCode.php", params: parameterss,completionHandler: completionHandler)
        
    }
    
    func postgetPromoCode(urlString: String, params: [String:String], completionHandler: ([[String: AnyObject]]?, NSError?) -> ()) {
        
        Alamofire.request(.POST, urlString, parameters: params)
            
            .responseJSON { res in
                switch res.result {
                case .Success(let dfr):
                    completionHandler(dfr as? [[String:AnyObject]], nil)
                    print("Data \(dfr)")
                case .Failure(let err):
                    completionHandler(nil, err)
                    
                }
        }
        
    }
    
    func nonMemberRequest(urlString: String, params: [String:String], completionHandler: ([[String:AnyObject]]?, NSError?) -> ()) {
        
        let manager = Manager.sharedInstance
        // Specifying the Headers we need
        manager.session.configuration.HTTPAdditionalHeaders = [
            "Content-Type": "application/x-www-form-urlencoded"]
        
        Alamofire.request(.POST, urlString, parameters: params)
            
            .responseJSON { res in
                
                switch res.result {
                case .Success(let list):
                    completionHandler(list as? [[String:AnyObject]], nil)
                case .Failure(let error):
                    completionHandler(nil, error)
                }
                
        }
        
    }
    
    
    func nonMemberList(parameterss: [String:String], completionHandler: ([[String:AnyObject]]?, NSError?) -> ()) {
        
        self.nonMemberRequest("http://macbooks-macbook-pro.local/webservices/getTravels.php", params: parameterss, completionHandler: completionHandler)
        
    }
    
    func postPromotionRequest(urlString: String, completionHandler: ([[String:AnyObject]]?, NSError?) -> ()) {
        
        let manager = Manager.sharedInstance
        // Specifying the Headers we need
        manager.session.configuration.HTTPAdditionalHeaders = [
            "Content-Type": "application/x-www-form-urlencoded"]
        
        Alamofire.request(.POST, urlString)
            
            .responseJSON { res in
                
                switch res.result {
                case .Success(let list):
                    completionHandler(list as? [[String:AnyObject]], nil)
                    
                case .Failure(let error):
                    completionHandler(nil, error)
                }
                
            }
        
    }
    
    func promotions(completionHandler: ([[String:AnyObject]]?, NSError?) -> ()) {
        
        self.postPromotionRequest("http://macbooks-macbook-pro.local/webservices/getPromo.php", completionHandler: completionHandler)
        
    }
    
    func postLocationsRequest(urlString: String, completionHandler: ([[String:AnyObject]]?, NSError?) -> ()) {
        
        let manager = Manager.sharedInstance
        // Specifying the Headers we need
        manager.session.configuration.HTTPAdditionalHeaders = [
            "Content-Type": "application/x-www-form-urlencoded"]
        
        Alamofire.request(.POST, urlString)
            
            .responseJSON { res in
                
                switch res.result {
                case .Success(let list):
                    completionHandler(list as? [[String:AnyObject]], nil)
                    
                case .Failure(let error):
                    completionHandler(nil, error)
                }
                
        }
        
    }
    
    
    func travelLocations(completionHandler: ([[String:AnyObject]]?, NSError?) -> ()) {
        
        self.postPromotionRequest("http://macbooks-macbook-pro.local/webservices/getTravelLocations.php", completionHandler: completionHandler)
        
    }

    
    func getUserData(parameterss: [String:String], completionHandler: ([[String: AnyObject]]?, NSError?) -> ()) {
        
        self.postgetUsersRequest("http://macbooks-macbook-pro.local/webservices/getEditUser.php", params: parameterss,completionHandler: completionHandler)
        
    }
    
    func postgetUsersRequest(urlString: String, params: [String:String], completionHandler: ([[String: AnyObject]]?, NSError?) -> ()) {
        
        Alamofire.request(.POST, urlString, parameters: params)
            
            .responseJSON { res in
                switch res.result {
                case .Success(let dfr):
                    completionHandler(dfr as? [[String:AnyObject]], nil)
                    print("Data \(dfr)")
                case .Failure(let err):
                    completionHandler(nil, err)
                    
                }
        }
        
    }
    
    func editUserRequest(urlString: String, params: [String:String], completionHandler: (NSDictionary?, NSError?) -> ()) {
        
        let manager = Manager.sharedInstance
        // Specifying the Headers we need
        manager.session.configuration.HTTPAdditionalHeaders = [
            "Content-Type": "application/x-www-form-urlencoded"]
        
        Alamofire.request(.POST, urlString, parameters: params)
            
            .responseJSON { res in
                switch res.result {
                case .Success(let dfr):
                    completionHandler(dfr as? NSDictionary, nil)
                    print("\(dfr)")
                case .Failure(let err):
                    completionHandler(nil, err)
                    
                }
        }
        
    }
    
    func editUsers(parameterss: [String:String], completionHandler: (NSDictionary?, NSError?) -> ()) {
        
        self.editUserRequest("http://macbooks-macbook-pro.local/webservices/editUser.php", params: parameterss, completionHandler: completionHandler)
        
    }
    
    func editPassRequest(urlString: String, params: [String:String], completionHandler: (NSDictionary?, NSError?) -> ()) {
        
        let manager = Manager.sharedInstance
        // Specifying the Headers we need
        manager.session.configuration.HTTPAdditionalHeaders = [
            "Content-Type": "application/x-www-form-urlencoded"]
        
        Alamofire.request(.POST, urlString, parameters: params)
            
            .responseJSON { res in
                switch res.result {
                case .Success(let dfr):
                    completionHandler(dfr as? NSDictionary, nil)
                    print("\(dfr)")
                case .Failure(let err):
                    completionHandler(nil, err)
                    
                }
        }
        
    }
    
    func editPass(parameterss: [String:String], completionHandler: (NSDictionary?, NSError?) -> ()) {
        
        self.editPassRequest("http://macbooks-macbook-pro.local/webservices/editPass.php", params: parameterss, completionHandler: completionHandler)
        
    }
    
    func postAddBookingRequest(urlString: String, params: [String:String], completionHandler: (NSDictionary?, NSError?) -> ()) {
        
        let manager = Manager.sharedInstance
        // Specifying the Headers we need
        manager.session.configuration.HTTPAdditionalHeaders = [
            "Content-Type": "application/x-www-form-urlencoded"]
        
        Alamofire.request(.POST, urlString, parameters: params)
            
            .responseJSON { res in
                switch res.result {
                case .Success(let dfr):
                    completionHandler(dfr as? NSDictionary, nil)
                    print(" Add Booking : \(dfr)")
                case .Failure(let err):
                    completionHandler(nil, err)
                    
                }
        }
        
    }
    
    func addNewBooking(parameterss: [String:String], completionHandler: (NSDictionary?, NSError?) -> ()) {
        
        self.postAddBookingRequest("http://macbooks-macbook-pro.local/webservices/addBooking.php", params: parameterss, completionHandler: completionHandler)
        
    }

    func getBookingData(parameterss: [String:String], completionHandler: ([[String: AnyObject]]?, NSError?) -> ()) {
        
        self.postBookingRequest("http://macbooks-macbook-pro.local/webservices/getBooking.php", params: parameterss,completionHandler: completionHandler)
        
    }
    
    func postBookingRequest(urlString: String, params: [String:String], completionHandler: ([[String: AnyObject]]?, NSError?) -> ()) {
        
        Alamofire.request(.POST, urlString, parameters: params)
            
            .responseJSON { res in
                switch res.result {
                case .Success(let dfr):
                    completionHandler(dfr as? [[String:AnyObject]], nil)
                    print("Data \(dfr)")
                case .Failure(let err):
                    completionHandler(nil, err)
                    
                }
        }
        
    }
    
    func postHotelRequest(urlString: String, params: [String:String], completionHandler: ([[String: AnyObject]]?, NSError?) -> ()) {
        
        Alamofire.request(.POST, urlString, parameters: params)
        
            .responseJSON { res in
                
                switch res.result {
                case .Success(let dfr):
                    completionHandler(dfr as? [[String:AnyObject]], nil)
                    print("Data \(dfr)")
                case .Failure(let err):
                    completionHandler(nil, err)
                }
                
            }
        
    }

}

