//
//  doctorTableViewCell.swift
//  Olacare
//
//  Created by Anthony Bravo on 4/23/19.
//  Copyright © 2019 Anthony Bravo. All rights reserved.
//

import UIKit
import SwiftyStarRatingView

class doctorTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var rainbowStampImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var specialtiesLabel: UILabel!
    @IBOutlet weak var starRatingView: SwiftyStarRatingView!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
