//
//  SortOptionsCell.swift
//  dashboardKB
//
//  Created by Hainizam on 05/06/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class SortOptionsCell: UITableViewCell {
    
    @IBOutlet weak var recentSwitch: UISwitch!
    @IBOutlet weak var favouriteSwitch: UISwitch!
    @IBOutlet weak var nearbySwitch: UISwitch!
    
    @IBOutlet weak var sortView: UIView!
    
    override func awakeFromNib() {
        print("Sort by..!")
        
        recentSwitch.isOn = false
        favouriteSwitch.isOn = false
        nearbySwitch.isOn = false
        
        self.sortView.layer.cornerRadius = 3
        self.sortView.layer.masksToBounds = true
        
        recentSwitch.addTarget(self, action: #selector(recentSwitchChange(_:)), for: .touchUpInside)
        favouriteSwitch.addTarget(self, action: #selector(favouriteSwitchChange(_:)), for: .touchUpInside)
        nearbySwitch.addTarget(self, action: #selector(nearbySwitchChange(_:)), for: .touchUpInside)
    }
    
    func recentSwitchChange(_ sender: UISwitch) {
        
        if recentSwitch.isOn {
            
            favouriteSwitch.isOn = false
            nearbySwitch.isOn = false
        }
    }
    
    func favouriteSwitchChange(_ sender: UISwitch) {
        
        if favouriteSwitch.isOn {
            
            recentSwitch.isOn = false
            nearbySwitch.isOn = false
        }
    }
    
    func nearbySwitchChange(_ sender: UISwitch) {
        
        if nearbySwitch.isOn {
            
            favouriteSwitch.isOn = false
            recentSwitch.isOn = false
        }
    }
}
