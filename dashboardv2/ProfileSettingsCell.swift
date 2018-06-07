//
//  ProfileSettingsCell.swift
//  dashboardKB
//
//  Created by Hainizam on 12/04/2018.
//  Copyright © 2018 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class ProfileSettingsCell: UITableViewCell {
    
    let featuredImageView: UIImageView = {
        
        var iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "default_avatar")
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 5.0
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let menuLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Edit password"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupAutoLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAutoLayout() {
        
        addSubview(featuredImageView)
        addSubview(menuLabel)
        
        featuredImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8.0).isActive = true
        featuredImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8.0).isActive = true
        featuredImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8.0).isActive = true
        featuredImageView.widthAnchor.constraint(equalTo: featuredImageView.heightAnchor).isActive = true
        
        menuLabel.centerYAnchor.constraint(equalTo: featuredImageView.centerYAnchor).isActive = true
        menuLabel.leadingAnchor.constraint(equalTo: featuredImageView.trailingAnchor, constant: 8.0).isActive = true
        menuLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8.0).isActive = true
    }
}














