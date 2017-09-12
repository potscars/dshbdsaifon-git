//
//  MMMenuListTVCell.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 27/12/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MMMenuListTVCell: UITableViewCell {

    @IBOutlet weak var uiivMMLTVCIcon: UIImageView!
    @IBOutlet weak var uilMMLTVCLabel: UILabel!
    @IBOutlet weak var uiivMMLTVCMenuBgImg: UIImageView!
    @IBOutlet weak var uivMMLTVCMenuBgOvl: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateCell(data: NSDictionary)
    {
        uilMMLTVCLabel.text = data.value(forKey: "MenuString") as? String
        uilMMLTVCLabel.font = UIFont(name: "RobotoCondensed-Light", size: 22.0)
        uiivMMLTVCIcon.image = data.value(forKey: "IconString") as? UIImage
        self.backgroundColor = data.value(forKey: "ColorObject") as? UIColor
        
        uiivMMLTVCMenuBgImg.image = data.value(forKey: "MenuBgImage") as? UIImage ?? UIImage.init(named: "ic_menu_myskool")
        uiivMMLTVCMenuBgImg.contentMode = UIViewContentMode.scaleAspectFill
        uivMMLTVCMenuBgOvl.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        /*
        let overlay: UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: uiivMMLTVCMenuBgImg.frame.width, height: uiivMMLTVCMenuBgImg.frame.height))
        overlay.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        uiivMMLTVCMenuBgImg.addSubview(overlay)
        
        let overlayHorizontalConstraint = NSLayoutConstraint(item: overlay, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: uiivMMLTVCMenuBgImg, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        let overlayVerticalConstraint = NSLayoutConstraint(item: overlay, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: uiivMMLTVCMenuBgImg, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
        
        uiivMMLTVCMenuBgImg.addConstraints([overlayHorizontalConstraint,overlayVerticalConstraint])
         */
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
