//
//  NotificationCell.swift
//  dashboardKB
//
//  Created by Hainizam on 12/04/2018.
//  Copyright © 2018 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell {
    
    let featuredImageView: UIImageView = {
        
        var iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "kimbab_sushi")
        iv.clipsToBounds = true
        return iv
    }()
    
    let notificationTextview: UITextView = {
        
        var tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        
        var attributedText = NSMutableAttributedString(string: "Dwayne Johnson ", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.bold)])
        attributedText.append(NSAttributedString(string: "telah memberitahu tentang cuaca buruk yang akan berlaku.", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)]))
        tv.attributedText = attributedText
        tv.textContainer.maximumNumberOfLines = 10
        tv.textContainer.lineBreakMode = .byTruncatingTail
        tv.isScrollEnabled = false
        tv.isEditable = false
        tv.isUserInteractionEnabled = false
        
        return tv
    }()
    
    var holderView = HolderView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupAutoLayoutForHolderView()
        setupAutoLayoutForHolderViewSubviews()
    }
    
    private func setupAutoLayoutForHolderView() {
        contentView.addSubview(holderView)
        
        holderView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0).isActive = true
        holderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8.0).isActive = true
        holderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8.0).isActive = true
        holderView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0).isActive = true
        
        holderView.layoutSubviews()
    }
    
    //setup layout untuk content dalam cell
    private func setupAutoLayoutForHolderViewSubviews() {
        
        holderView.addSubview(featuredImageView)
        holderView.addSubview(notificationTextview)
        
        featuredImageView.topAnchor.constraint(equalTo: holderView.topAnchor, constant: 8.0).isActive = true
        featuredImageView.leftAnchor.constraint(equalTo: holderView.leftAnchor, constant: 8.0).isActive = true
        featuredImageView.bottomAnchor.constraint(equalTo: holderView.bottomAnchor, constant: -8.0).isActive = true
        featuredImageView.widthAnchor.constraint(equalTo: featuredImageView.heightAnchor).isActive = true
        
        notificationTextview.centerYAnchor.constraint(equalTo: featuredImageView.centerYAnchor).isActive = true
        notificationTextview.leadingAnchor.constraint(equalTo: featuredImageView.trailingAnchor, constant: 8.0).isActive = true
        notificationTextview.trailingAnchor.constraint(equalTo: holderView.trailingAnchor, constant: -8.0).isActive = true
        
        layoutSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

















