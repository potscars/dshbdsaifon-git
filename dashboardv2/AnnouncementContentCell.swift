//
//  AnnouncementContentCell.swift
//  dashboardKB
//
//  Created by Hainizam on 20/02/2018.
//  Copyright © 2018 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class AnnouncementContentCell: UITableViewCell {
    
    let featuredImageView: UIImageView = {
        var iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "default_avatar")
        iv.clipsToBounds = true
        return iv
    }()
    
    let postOwnerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "APM - Kota Belud"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    let postDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "6 February 2018, 09:05:23 AM"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    let contentTextview: UITextView = {
        
        var tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        
        var attributedText = NSMutableAttributedString(string: "Amaran Ribut Petir", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.medium)])
        attributedText.append(NSAttributedString(string: "\n\nDikeluarkan pada: 5 February 2018, 03:05:23 AM.", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)]))
        attributedText.append(NSAttributedString(string: "\n\nThe line is displayed so that the beginning fits in the container and the missing text at the end of the line is indicated by an ellipsis glyph. Although this mode works for multiline text, it is more often used for single line text. The line is displayed so that the beginning fits in the container and the missing text at the end of the line is indicated by an ellipsis glyph. Although this mode works for multiline text, it is more often used for single line text.", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)]))
        tv.attributedText = attributedText
        tv.textContainer.maximumNumberOfLines = 10
        tv.textContainer.lineBreakMode = .byTruncatingTail
        tv.isScrollEnabled = false
        tv.isEditable = false
        
        return tv
    }()
    
    let holderView = HolderView()
    
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
        
        holderView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0).isActive = true
        holderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8.0).isActive = true
        holderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8.0).isActive = true
        holderView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0).isActive = true
        
        holderView.layoutSubviews()
    }
    
    private func setupAutoLayoutForHolderViewSubviews() {
        
        holderView.addSubview(featuredImageView)
        holderView.addSubview(postOwnerLabel)
        holderView.addSubview(postDateLabel)
        holderView.addSubview(contentTextview)
        
        featuredImageView.topAnchor.constraint(equalTo: holderView.topAnchor, constant: 8.0).isActive = true
        featuredImageView.leftAnchor.constraint(equalTo: holderView.leftAnchor, constant: 8.0).isActive = true
        featuredImageView.heightAnchor.constraint(equalToConstant: 56.0).isActive = true
        featuredImageView.widthAnchor.constraint(equalToConstant: 56.0).isActive = true
        
        postOwnerLabel.topAnchor.constraint(equalTo: holderView.topAnchor, constant: 8.0).isActive = true
        postOwnerLabel.leftAnchor.constraint(equalTo: featuredImageView.rightAnchor, constant: 8.0).isActive = true
        postOwnerLabel.rightAnchor.constraint(equalTo: holderView.rightAnchor, constant: -8.0).isActive = true
        
        postDateLabel.topAnchor.constraint(equalTo: postOwnerLabel.bottomAnchor, constant: 4.0).isActive = true
        postDateLabel.leftAnchor.constraint(equalTo: featuredImageView.rightAnchor, constant: 8.0).isActive = true
        postDateLabel.rightAnchor.constraint(equalTo: holderView.rightAnchor, constant: -8.0).isActive = true
        postDateLabel.bottomAnchor.constraint(equalTo: featuredImageView.bottomAnchor, constant: -8.0).isActive = true
        
        contentTextview.topAnchor.constraint(equalTo: featuredImageView.bottomAnchor, constant: 8.0).isActive = true
        contentTextview.leftAnchor.constraint(equalTo: holderView.leftAnchor, constant: 8.0).isActive = true
        contentTextview.rightAnchor.constraint(equalTo: holderView.rightAnchor, constant: -8.0).isActive = true
        contentTextview.bottomAnchor.constraint(equalTo: holderView.bottomAnchor, constant: -8.0).isActive = true
        
        layoutSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}














