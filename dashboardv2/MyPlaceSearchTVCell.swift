//
//  MyPlaceSearchTVCell.swift
//  dashboardKB
//
//  Created by Mohd Zulhilmi Mohd Zain on 18/04/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MyPlaceSearchTVCell: UITableViewCell {
    
    @IBOutlet weak var uilMPSTVCTitle: UILabel!
    @IBOutlet weak var uilMPSTVCSearchList: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateSearchList(data: NSDictionary) {
        
        uilMPSTVCSearchList.text = String(describing: data.value(forKey: "SEARCH_HISTORY_NAME")!)
        
    }

}
