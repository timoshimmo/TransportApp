//
//  HistoryTableViewCell.swift
//  YobeTravels
//
//  Created by MacBook Pro on 28/05/2016.
//  Copyright © 2016 AJE AJE. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var lblBusCompany: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblTrip: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
