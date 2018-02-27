//
//  EmergencyInfoCell.swift
//  dashboardKB
//
//  Created by Hainizam on 21/02/2018.
//  Copyright © 2018 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class EmergencyInfoCell: UITableViewCell {

    let holderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.autoresizesSubviews = true
        return view
    }()
    
    let featuredImageView: UIImageView = {
        var iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "default_avatar")
        iv.clipsToBounds = true
        return iv
    }()
    
    let emergencyAgentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Pejabat Daerah - Kota Belud"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    let emergencyLineNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "084245649"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupAutoLayoutForHolderView()
        setupAutoLayoutForHolderViewSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let shadowPath = UIBezierPath(rect: holderView.bounds)
        holderView.layer.masksToBounds = false
        holderView.layer.shadowColor = UIColor.black.cgColor
        holderView.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        holderView.layer.shadowOpacity = 0.5
        holderView.layer.shadowPath = shadowPath.cgPath
    }
    
    private func setupAutoLayoutForHolderView() {
        contentView.addSubview(holderView)
        
        holderView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0).isActive = true
        holderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8.0).isActive = true
        holderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8.0).isActive = true
        holderView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0).isActive = true
    }
    
    private func setupAutoLayoutForHolderViewSubviews() {
        
        holderView.addSubview(featuredImageView)
        holderView.addSubview(emergencyAgentLabel)
        holderView.addSubview(emergencyLineNumberLabel)
        
        featuredImageView.topAnchor.constraint(equalTo: holderView.topAnchor, constant: 8.0).isActive = true
        featuredImageView.leftAnchor.constraint(equalTo: holderView.leftAnchor, constant: 8.0).isActive = true
        featuredImageView.heightAnchor.constraint(equalToConstant: 56.0).isActive = true
        featuredImageView.widthAnchor.constraint(equalToConstant: 56.0).isActive = true
        
        emergencyAgentLabel.topAnchor.constraint(equalTo: holderView.topAnchor, constant: 8.0).isActive = true
        emergencyAgentLabel.leftAnchor.constraint(equalTo: featuredImageView.rightAnchor, constant: 8.0).isActive = true
        emergencyAgentLabel.rightAnchor.constraint(equalTo: holderView.rightAnchor, constant: -8.0).isActive = true
        
        emergencyLineNumberLabel.topAnchor.constraint(equalTo: emergencyAgentLabel.bottomAnchor, constant: 4.0).isActive = true
        emergencyLineNumberLabel.leftAnchor.constraint(equalTo: featuredImageView.rightAnchor, constant: 8.0).isActive = true
        emergencyLineNumberLabel.rightAnchor.constraint(equalTo: holderView.rightAnchor, constant: -8.0).isActive = true
        emergencyLineNumberLabel.bottomAnchor.constraint(equalTo: featuredImageView.bottomAnchor, constant: -8.0).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}












