//
//  DetailsSensorCell.swift
//  dashboardKB
//
//  Created by Hainizam on 14/02/2018.
//  Copyright © 2018 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class DetailsSensorCell: UITableViewCell {
    
    let holderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightBlue
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.autoresizesSubviews = true
        return view
    }()
    
    let sensorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    override func awakeFromNib() {
        backgroundColor = .lightGray
        contentView.backgroundColor = .black
        setupAutoLayoutForHolderView()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .lightGray
        contentView.backgroundColor = .black
        setupAutoLayoutForHolderView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupAutoLayout()
    }
    
    private func setupAutoLayoutForHolderView() {
        contentView.addSubview(holderView)
        
        holderView.topAnchor.constraint(equalTo: topAnchor, constant: 8.0).isActive = true
        holderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8.0).isActive = true
        holderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8.0).isActive = true
        holderView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0).isActive = true
    }
    
    private func setupAutoLayout() {
        
        var tempViewArray: [UIView] = []
        for i in 0...4 {
            let tempView = SensorView()
            tempViewArray.append(tempView)
        }
        
        let sensorWidth = (frame.width - 16) / 3
        let sensorHeight = (frame.height - 16) / 2
        
        for i in 0...4 {
            
            holderView.addSubview(tempViewArray[i])
            tempViewArray[i].heightAnchor.constraint(equalToConstant: sensorHeight).isActive = true
            tempViewArray[i].widthAnchor.constraint(equalToConstant: sensorWidth).isActive = true
            
            if i < 3 {
                
                tempViewArray[i].topAnchor.constraint(equalTo: holderView.topAnchor).isActive = true
                if i == 0 {
                    tempViewArray[i].leadingAnchor.constraint(equalTo: holderView.leadingAnchor).isActive = true
                    tempViewArray[i].backgroundColor = .red
                } else {
                    
                    if i % 2 == 0 {
                        tempViewArray[i].trailingAnchor.constraint(equalTo: holderView.trailingAnchor).isActive = true
                        tempViewArray[i].backgroundColor = .green
                    } else {
                        tempViewArray[i].leadingAnchor.constraint(equalTo: tempViewArray[i - 1].trailingAnchor).isActive = true
                    }
                }
            } else {
                
                tempViewArray[i].topAnchor.constraint(equalTo: tempViewArray[0].bottomAnchor).isActive = true
                if i == 3 {
                    tempViewArray[i].leadingAnchor.constraint(equalTo: holderView.leadingAnchor).isActive = true
                    tempViewArray[i].backgroundColor = .red
                } else {
                    
                    if i % 5 == 0 {
                        tempViewArray[i].trailingAnchor.constraint(equalTo: holderView.trailingAnchor).isActive = true
                        tempViewArray[i].backgroundColor = .green
                    } else {
                        tempViewArray[i].leadingAnchor.constraint(equalTo: tempViewArray[i - 1].trailingAnchor).isActive = true
                    }
                }
            }
        }
    }
}

class SensorView: UIView {
    
    let imageView: UIImageView = {
       
        var iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "default_avatar")
        return iv
    }()
    
    let descriptionTextview: UITextView = {
       
        var tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        
        var attributedText = NSMutableAttributedString(string: "Sensor", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.medium)])
        attributedText.append(NSAttributedString(string: "\nSensor to the fullest", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 8, weight: UIFont.Weight.regular)]))
        tv.attributedText = attributedText
        
        tv.isScrollEnabled = false
        tv.isEditable = false
        tv.textAlignment = .center

        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .yellow
        translatesAutoresizingMaskIntoConstraints = false
        
        setupAutoLayout()
    }
    
    private func setupAutoLayout() {
        
        addSubview(imageView)
        
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 4.0).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
        
        addSubview(descriptionTextview)
        
        descriptionTextview.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        descriptionTextview.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        descriptionTextview.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        descriptionTextview.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}







