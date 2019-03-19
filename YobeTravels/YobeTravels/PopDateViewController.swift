//
//  PopDateViewController.swift
//  YobeTravels
//
//  Created by MacBook Pro on 2/22/16.
//  Copyright © 2016 AJE AJE. All rights reserved.
//

import UIKit

protocol DatePickerViewControllerDelegate : class {
    
    func datePickerVCDismissed(date : NSDate?)
}

class PopDateViewController: UIViewController {
    @IBOutlet weak var datePicker: UIDatePicker!

    @IBOutlet weak var container: UIView!
 
    weak var delegate : DatePickerViewControllerDelegate?
    
    var currentDate : NSDate? {
        didSet {
            updatePickerCurrentDate()
        }
    }
    
    convenience init() {
        
        self.init(nibName: "PopDateViewController", bundle: nil)
    }
    
    private func updatePickerCurrentDate() {
        
        if let _currentDate = self.currentDate {
            if let _datePicker = self.datePicker {
                _datePicker.date = _currentDate
            }
        }
    }
    
    
    @IBAction func okAction(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true) {
            
            let nsdate = self.datePicker.date
            self.delegate?.datePickerVCDismissed(nsdate)
            
        }
    }
    
    override func viewDidLoad() {
        
        updatePickerCurrentDate()
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        
        self.delegate?.datePickerVCDismissed(nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
