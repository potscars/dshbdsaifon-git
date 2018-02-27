//
//  RiverCautionsLevelStackView.swift
//  dashboardKB
//
//  Created by Hainizam on 20/02/2018.
//  Copyright © 2018 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class RiverCautionsLevelStackView: UIStackView {
    
    let dangerTextview: UITextView = {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        
        var attributedText = NSMutableAttributedString(string: "Bahaya", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.medium)])
        attributedText.append(NSAttributedString(string: "\n5.5m", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.medium)]))
        tv.attributedText = attributedText
        
        tv.isScrollEnabled = false
        tv.isEditable = false
        tv.textAlignment = .center
        tv.textColor = .white
        tv.backgroundColor = .lightRed
        tv.textContainerInset = UIEdgeInsetsMake(0, 8, 0, 8)
        
        return tv
    }()
    
    let warningTextview: UITextView = {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        
        var attributedText = NSMutableAttributedString(string: "Amaran", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.medium)])
        attributedText.append(NSAttributedString(string: "\n4.7m", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.medium)]))
        tv.attributedText = attributedText
        
        tv.isScrollEnabled = false
        tv.isEditable = false
        tv.textAlignment = .center
        tv.textColor = .white
        tv.backgroundColor = .lightOrange
        tv.textContainerInset = UIEdgeInsetsMake(0, 8, 0, 8)
        
        return tv
    }()
    
    let cautionTextview: UITextView = {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        
        var attributedText = NSMutableAttributedString(string: "Berjaga", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.medium)])
        attributedText.append(NSAttributedString(string: "\n4.3m", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.medium)]))
        tv.attributedText = attributedText
        
        tv.isScrollEnabled = false
        tv.isEditable = false
        tv.textAlignment = .center
        tv.textColor = .black
        tv.backgroundColor = .lightYellow
        tv.textContainerInset = UIEdgeInsetsMake(0, 8, 0, 8)
        
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        axis = .horizontal
        alignment = .center
        distribution = .fillEqually
        translatesAutoresizingMaskIntoConstraints = false
        
        setupAutoLayout()
    }
    
    private func setupAutoLayout() {
        
        addArrangedSubview(dangerTextview)
        addArrangedSubview(warningTextview)
        addArrangedSubview(cautionTextview)
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}













