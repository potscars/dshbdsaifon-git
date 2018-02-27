//
//  RiverLevelDetailsView.swift
//  dashboardKB
//
//  Created by Hainizam on 20/02/2018.
//  Copyright © 2018 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class RiverLevelDetailsView: UIView {
    
    let featuredImageView: UIImageView = {
        var iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "default_avatar")
        iv.clipsToBounds = true
        return iv
    }()
    
    let riverNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Sungai Kedamaian"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.sizeToFit()
        return label
    }()
    
    let riverLevelStackView: UIStackView = {
       let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.alignment = .bottom
        return sv
    }()
    
    let currentRiverLevelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "0.95m"
        label.font = UIFont.systemFont(ofSize: 28, weight: .medium)
        return label
    }()
    
    let differenceRiverLevelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "0.01m"
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        return label
    }()
    
    let previousWaterLevelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "water level an hour ago: 0.96m"
        label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        return label
    }()
    
    let imagePadding: CGFloat = 16.0
    let dangerLevelStackView = RiverCautionsLevelStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .lightBlue
        
        setupAutoLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    private func setupAutoLayout() {
        
        addSubview(featuredImageView)
        addSubview(riverNameLabel)
        addSubview(riverLevelStackView)
        addSubview(dangerLevelStackView)
        addSubview(previousWaterLevelLabel)
        
        featuredImageView.topAnchor.constraint(equalTo: topAnchor, constant: imagePadding).isActive = true
        featuredImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8.0).isActive = true
        featuredImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -imagePadding).isActive = true
        featuredImageView.widthAnchor.constraint(equalTo: featuredImageView.heightAnchor).isActive = true
        
        riverNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0.0).isActive = true
        riverNameLabel.leftAnchor.constraint(equalTo: featuredImageView.rightAnchor, constant: 8.0).isActive = true
        riverNameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16.0).isActive = true
        
        setupStackViewAutoLayout()
        
        previousWaterLevelLabel.topAnchor.constraint(equalTo: dangerLevelStackView.bottomAnchor, constant: 0.0).isActive = true
        previousWaterLevelLabel.leftAnchor.constraint(equalTo: featuredImageView.rightAnchor, constant: 8.0).isActive = true
        previousWaterLevelLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16.0).isActive = true
    }
    
    private func setupStackViewAutoLayout() {
        
        riverLevelStackView.topAnchor.constraint(equalTo: riverNameLabel.bottomAnchor, constant: 0.0).isActive = true
        riverLevelStackView.leftAnchor.constraint(equalTo: featuredImageView.rightAnchor, constant: 8.0).isActive = true
        riverLevelStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16.0).isActive = true
        riverLevelStackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.35).isActive = true
        
        riverLevelStackView.addArrangedSubview(currentRiverLevelLabel)
        riverLevelStackView.addArrangedSubview(differenceRiverLevelLabel)
        
        dangerLevelStackView.topAnchor.constraint(equalTo: riverLevelStackView.bottomAnchor, constant: 0.0).isActive = true
        dangerLevelStackView.leftAnchor.constraint(equalTo: featuredImageView.rightAnchor, constant: 8.0).isActive = true
        dangerLevelStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16.0).isActive = true
        dangerLevelStackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}












