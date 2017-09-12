//
//  ProfileIntegratedTVCell.swift
//  dashboardKB
//
//  Created by Mohd Zulhilmi Mohd Zain on 25/03/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class ProfileIntegratedTVCell: UITableViewCell {

    //ProfileTitleCellID, height 50
    @IBOutlet weak var uilPTVCTitleLabel: UILabel!
    
    //ProfileImageCellID, height 130
    @IBOutlet weak var uiivPTVCProfileImage: UIImageView!
    
    //ProfileDetailsCellID, height 60
    @IBOutlet weak var uilPTVCDetailsTitle: UILabel!
    @IBOutlet weak var uilPTVCDetailsDesc: UILabel!
    
    //ProfileFinishCellID, height 60
    @IBOutlet weak var uibPTVCFinishBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateProfile(data: NSDictionary)
    {
        uilPTVCDetailsTitle.text = String(describing: data.value(forKey: "PROFILE_LABEL")!)
        uilPTVCDetailsDesc.text = String(describing: data.value(forKey: "PROFILE_DESC")!)
    }

    func applyCloseButton(viewController: UIViewController) {
        
        
    }
    
}
