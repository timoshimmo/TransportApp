//
//  HotelsTableViewCell.swift
//  YobeTravels
//
//  Created by MacBook Pro on 06/07/2016.
//  Copyright © 2016 AJE AJE. All rights reserved.
//

import UIKit

class HotelsTableViewCell: UITableViewCell {

    @IBOutlet weak var imgHotel: UIImageView!
    
    @IBOutlet weak var hotelName: UILabel!
    
    @IBOutlet weak var hotelState: UILabel!
    
    @IBOutlet weak var promoDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
