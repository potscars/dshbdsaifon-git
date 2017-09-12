//
//  MyPlaceProfileHistoryTVCell.swift
//  dashboardKB
//
//  Created by Mohd Zulhilmi Mohd Zain on 13/04/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MyPlaceProfileHistoryTVCell: UITableViewCell {

    @IBOutlet weak var uiivMPPHTVCListPic: UIImageView!
    @IBOutlet weak var uilMPPHTVCPlaceName: UILabel!
    @IBOutlet weak var uilMPPHTVCPlaceAddress: UILabel!
    @IBOutlet weak var uilMPPHTVCPlaceDate: UILabel!
    @IBOutlet weak var uibMPPHTVCPlaceEdit: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
