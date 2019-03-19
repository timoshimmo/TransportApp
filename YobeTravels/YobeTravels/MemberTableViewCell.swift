//
//  MemberTableViewCell.swift
//  YobeTravels
//
//  Created by MacBook Pro on 13/05/2016.
//  Copyright © 2016 AJE AJE. All rights reserved.
//

import UIKit

class MemberTableViewCell: UITableViewCell {

    @IBOutlet var memBusCompany: UILabel!
    @IBOutlet var memPrice: UILabel!
    @IBOutlet var memDateTime: UILabel!
    @IBOutlet var memStation: UILabel!
    @IBOutlet weak var memDestination: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
