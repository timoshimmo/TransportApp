//
//  MenuTableViewCell.swift
//  YobeTravels
//
//  Created by MacBook Pro on 09/05/2016.
//  Copyright © 2016 AJE AJE. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet var menuString: UILabel!
    @IBOutlet var menuImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
