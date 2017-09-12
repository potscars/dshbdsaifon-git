//
//  SearchResultDetailsCell.swift
//  dashboardKB
//
//  Created by Hainizam on 14/06/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class SearchResultDetailsCell: UITableViewCell {
    
    @IBOutlet weak var aboutDetailsLabel: UILabel!
    
    var aboutString: String? {
        didSet {
            self.aboutUpdate()
        }
    }
    
    func aboutUpdate() {
        
        self.aboutDetailsLabel.text = "Here at Sysaban restaurant, we are proud to serve the beauty of globalization of food to our regulars and fans. Every day, our kitchen has been utilized for a highly globalized process where famous Paskitani polished long grain Basmati has been used together with highly energetic Egyptian ghee together with freshly delivered Australian young and soft lamb, spiced with highly valued since the ancient times, lines of fresh Yemeni spices. All this freshness is proudly brought to you by Sysaban restaurant."
    }
}
