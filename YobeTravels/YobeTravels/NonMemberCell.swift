//
//  NonMemberCell.swift
//  YobeTravels
//
//  Created by MacBook Pro on 3/15/16.
//  Copyright © 2016 AJE AJE. All rights reserved.
//

import UIKit

class NonMemberCell: UITableViewCell {

    @IBOutlet weak var busCompany: UILabel!
    @IBOutlet weak var lblStation: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
