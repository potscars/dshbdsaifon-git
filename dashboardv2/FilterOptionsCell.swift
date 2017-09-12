//
//  FilterOptionsCell.swift
//  dashboardKB
//
//  Created by Hainizam on 05/06/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class FilterOptionsCell: UITableViewCell {
    
    @IBOutlet weak var accomodationSwitch: UISwitch!
    @IBOutlet weak var foodBeveragseSwitch: UISwitch!
    @IBOutlet weak var placeOfInterestSwitch: UISwitch!
    
    @IBOutlet weak var filterView: UIView!
    
    override func awakeFromNib() {
        print("Sort by..!")
        
        accomodationSwitch.isOn = false
        foodBeveragseSwitch.isOn = false
        placeOfInterestSwitch.isOn = false
        
        self.filterView.layer.cornerRadius = 3
        self.filterView.layer.masksToBounds = true
        
        accomodationSwitch.addTarget(self, action: #selector(accomodationSwitchChange(_:)), for: .touchUpInside)
        foodBeveragseSwitch.addTarget(self, action: #selector(foodBeveragesSwitchChange(_:)), for: .touchUpInside)
        placeOfInterestSwitch.addTarget(self, action: #selector(placeOfInterestSwitchChange(_:)), for: .touchUpInside)
    }
    
    func accomodationSwitchChange(_ sender: UISwitch) {
        
        if accomodationSwitch.isOn {
            
            foodBeveragseSwitch.isOn = false
            placeOfInterestSwitch.isOn = false
        }
    }
    
    func foodBeveragesSwitchChange(_ sender: UISwitch) {
        
        if foodBeveragseSwitch.isOn {
            
            accomodationSwitch.isOn = false
            placeOfInterestSwitch.isOn = false
        }
    }
    
    func placeOfInterestSwitchChange(_ sender: UISwitch) {
        
        if placeOfInterestSwitch.isOn {
            
            foodBeveragseSwitch.isOn = false
            accomodationSwitch.isOn = false
        }
    }
}
