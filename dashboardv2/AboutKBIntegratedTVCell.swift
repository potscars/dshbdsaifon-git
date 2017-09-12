//
//  AboutKBIntegratedTVCell.swift
//  dashboardKB
//
//  Created by Mohd Zulhilmi Mohd Zain on 27/03/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class AboutKBIntegratedTVCell: UITableViewCell {

    //AboutKBFirstCellID
    @IBOutlet weak var uilAKBITVCFirstTitle: UILabel!
    @IBOutlet weak var uilAKBITVCSecondTitle: UILabel!
    @IBOutlet weak var uilAKBITVCFirstCopy: UILabel!
    @IBOutlet weak var uilAKBITVCSecondCopy: UILabel!
    @IBOutlet weak var uilAKBITVCVerNo: UILabel!
    @IBOutlet weak var uilAKBITVCBuildNo: UILabel!
    
    //AboutKBAgenciesCellID
    @IBOutlet weak var uiivAKBITVCAgencyLogo: UIImageView!
    @IBOutlet weak var uilAKBITVCAgencyName: UILabel!
    @IBOutlet weak var uilAKBITVCAgencyEmail: UILabel!
    @IBOutlet weak var uilAKBITVCAgencyPhone: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updateAboutInfo(data: NSDictionary) {
        
        uilAKBITVCFirstTitle.text = String(describing: data.value(forKey: "ABOUT_TITLE_FIRST")!)
        uilAKBITVCSecondTitle.text = String(describing: data.value(forKey: "ABOUT_TITLE_SECOND")!)
        uilAKBITVCFirstCopy.text = String(describing: data.value(forKey: "ABOUT_COPY_FIRST")!)
        uilAKBITVCSecondCopy.text = String(describing: data.value(forKey: "ABOUT_COPY_SECOND")!)
        uilAKBITVCVerNo.text = String(describing: data.value(forKey: "ABOUT_COPY_VER")!)
        uilAKBITVCBuildNo.text = String(describing: data.value(forKey: "ABOUT_COPY_BUILD")!)
    }
    
    func updateAgencyInfo(data: NSDictionary) {
        
        uilAKBITVCAgencyName.text = String(describing: data.value(forKey: "ABOUT_AGENCY_NAME")!)
        uilAKBITVCAgencyEmail.text = String(describing: data.value(forKey: "ABOUT_AGENCY_EMAIL")!)
        uilAKBITVCAgencyPhone.text = String(describing: data.value(forKey: "ABOUT_AGENCY_PHONE")!)
        //uiivAKBITVCAgencyLogo.image = data.value(forKey: "ABOUT_AGENCY_LOGO") as? UIImage ?? UIImage.init(named: "ic_saifonlogo")
        //ABOUT_AGENCY_LOGO
    }
    
    func updateAgencyLogo(image: UIImage?) {
        
        self.uiivAKBITVCAgencyLogo.image = image!
        
    }
    
}
