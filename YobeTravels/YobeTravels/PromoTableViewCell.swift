//
//  PromoTableViewCell.swift
//  YobeTravels
//
//  Created by MacBook Pro on 13/05/2016.
//  Copyright © 2016 AJE AJE. All rights reserved.
//

import UIKit

class PromoTableViewCell: UITableViewCell {

    @IBOutlet var discountValue: UILabel!
    @IBOutlet var busComapny: UILabel!
    @IBOutlet var destination: UILabel!
    @IBOutlet var promoDuration: UILabel!
    @IBOutlet var addtionalInfo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
