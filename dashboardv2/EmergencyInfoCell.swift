//
//  EmergencyInfoCell.swift
//  dashboardKB
//
//  Created by Hainizam on 21/02/2018.
//  Copyright © 2018 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class EmergencyInfoCell: UITableViewCell {
    
    let featuredImageView: UIImageView = {
        var iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "default_avatar")
        iv.layer.cornerRadius = 5.0
        iv.clipsToBounds = true
        return iv
    }()
    
    let emergencyAgentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Pejabat Daerah - Kota Belud"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    let emergencyEmailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "emergency@alert.com"
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    let emergencyLineNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "084245649"
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
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
    
    var holderView = HolderView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupAutoLayoutForHolderView()
        setupAutoLayoutForHolderViewSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setupAutoLayoutForHolderView() {
        contentView.addSubview(holderView)
        
        holderView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4.0).isActive = true
        holderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8.0).isActive = true
        holderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8.0).isActive = true
        holderView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4.0).isActive = true
    }
    
    private func setupAutoLayoutForHolderViewSubviews() {
        
        holderView.addSubview(featuredImageView)
        holderView.addSubview(stackview)
        
        featuredImageView.centerYAnchor.constraint(equalTo: holderView.centerYAnchor).isActive = true
        featuredImageView.leadingAnchor.constraint(equalTo: holderView.leadingAnchor, constant: 8.0).isActive = true
        featuredImageView.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        featuredImageView.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
        
        stackview.addArrangedSubview(emergencyAgentLabel)
        stackview.addArrangedSubview(emergencyEmailLabel)
        stackview.addArrangedSubview(emergencyLineNumberLabel)
        
        stackview.centerYAnchor.constraint(equalTo: featuredImageView.centerYAnchor).isActive = true
        stackview.leadingAnchor.constraint(equalTo: featuredImageView.trailingAnchor, constant: 8.0).isActive = true
        stackview.trailingAnchor.constraint(equalTo: holderView.trailingAnchor, constant: -8.0).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCell(withInfo info: Careline) {
        
        emergencyAgentLabel.text = info.name
        emergencyEmailLabel.text = info.email
        emergencyLineNumberLabel.text = info.phoneNumber
    }
}












