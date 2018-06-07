//
//  ProfileHeaderView.swift
//  dashboardKB
//
//  Created by Hainizam on 12/04/2018.
//  Copyright © 2018 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class ProfileHeaderView: UIView {
    
    let featuredImageView: UIImageView = {
        
        var iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "kimbab_sushi")
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 5.0
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Dwayne Johnson"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "therock@thecooking.net"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    let stackview: UIStackView = {
        
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.distribution = .fill
        sv.alignment = .center
        
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAutolayout()
        backgroundColor = UIColor.superLightGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAutolayout() {
        
        addSubview(featuredImageView)
        addSubview(stackview)
        
        featuredImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        featuredImageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        featuredImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        featuredImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16.0).isActive = true
        
        stackview.topAnchor.constraint(equalTo: featuredImageView.bottomAnchor, constant: 8.0).isActive = true
        stackview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0).isActive = true
        stackview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0).isActive = true
        
        stackview.addArrangedSubview(nameLabel)
        stackview.addArrangedSubview(emailLabel)
    }
}








