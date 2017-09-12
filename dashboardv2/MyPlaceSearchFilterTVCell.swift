//
//  MyPlaceSearchFilterTVCell.swift
//  dashboardKB
//
//  Created by Mohd Zulhilmi Mohd Zain on 27/04/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MyPlaceSearchFilterTVCell: UITableViewCell {

    @IBOutlet weak var uibMPSFTVCTwoBtnFirstBtn: UIButton!
    @IBOutlet weak var uibMPSFTVCTwoBtnSecondBtn: UIButton!
    
    @IBOutlet weak var uibMPSFTVCOneBtnABtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateOneBtn(data: NSDictionary) {
        
        uibMPSFTVCOneBtnABtn.setTitle(String(describing:data.value(forKey: "FILTER_FIRST_BUTTON")!), for: UIControlState.normal)
        
    }
    
    func updateTwoBtn(data: NSDictionary) {
        
        uibMPSFTVCTwoBtnFirstBtn.setTitle(String(describing:data.value(forKey: "FILTER_FIRST_BUTTON")!), for: UIControlState.normal)
        uibMPSFTVCTwoBtnSecondBtn.setTitle(String(describing:data.value(forKey: "FILTER_SECOND_BUTTON")!), for: UIControlState.normal)
        
    }

}
