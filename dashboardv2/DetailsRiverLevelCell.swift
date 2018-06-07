//
//  DetailsRiverLevelCell.swift
//  dashboardKB
//
//  Created by Hainizam on 14/02/2018.
//  Copyright © 2018 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class DetailsRiverLevelCell: UITableViewCell {
    
    let venueNameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.text = "Kampung Piasau"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    let riverLevelDetailsView = RiverLevelDetailsView()
    let riverLevelGraphView = RiverLevelGraphView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .lightGray
        contentView.backgroundColor = .superLightGray
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupAutoLayout()
    }
    
    private func setupAutoLayout() {
        
        contentView.addSubview(venueNameLabel)
        contentView.addSubview(riverLevelDetailsView)
        contentView.addSubview(riverLevelGraphView)
        
        venueNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0).isActive = true
        venueNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8.0).isActive = true
        venueNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8.0).isActive = true
        venueNameLabel.heightAnchor.constraint(equalToConstant: 24.0).isActive = true
        
        riverLevelDetailsView.topAnchor.constraint(equalTo: venueNameLabel.bottomAnchor, constant: 8.0).isActive = true
        riverLevelDetailsView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8.0).isActive = true
        riverLevelDetailsView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8.0).isActive = true
        riverLevelDetailsView.heightAnchor.constraint(equalToConstant: 100.0).isActive = true

        riverLevelGraphView.topAnchor.constraint(equalTo: riverLevelDetailsView.bottomAnchor, constant: 8.0).isActive = true
        riverLevelGraphView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8.0).isActive = true
        riverLevelGraphView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8.0).isActive = true
        riverLevelGraphView.heightAnchor.constraint(equalToConstant: 150.0).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}






