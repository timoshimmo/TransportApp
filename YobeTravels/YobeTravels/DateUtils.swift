//
//  DateUtils.swift
//  YobeTravels
//
//  Created by MacBook Pro on 2/22/16.
//  Copyright © 2016 AJE AJE. All rights reserved.
//

import Foundation

extension NSDate {
    
    func ToDateMediumString() -> NSString? {
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = .ShortStyle;
        formatter.timeStyle = .NoStyle;
        return formatter.stringFromDate(self)
    }


}
