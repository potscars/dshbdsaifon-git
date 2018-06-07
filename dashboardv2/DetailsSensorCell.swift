//
//  DetailsSensorCell.swift
//  dashboardKB
//
//  Created by Hainizam on 14/02/2018.
//  Copyright © 2018 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class DetailsSensorCell: UITableViewCell {
    
    var holderView = HolderView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .lightGray
        contentView.backgroundColor = .superLightGray
        setupAutoLayoutForHolderView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupAutoLayout()
    }
    
    private func setupAutoLayoutForHolderView() {
        contentView.addSubview(holderView)
        
        holderView.topAnchor.constraint(equalTo: topAnchor, constant: 8.0).isActive = true
        holderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8.0).isActive = true
        holderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8.0).isActive = true
        holderView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0).isActive = true
    }
    
    var totalSensor = 4 // 0 - 5
    
    private func setupAutoLayout() {
        
        var tempViewArray: [UIView] = []
        for _ in 0...totalSensor {
            
            let tempView = SensorView()
            tempViewArray.append(tempView)
        }
        
        let sensorWidth = (frame.width - 16) / 3
        let sensorHeight = (frame.height - 16) / 2
        
        for i in 0...totalSensor {

            guard let sensorView = tempViewArray[i] as? SensorView else { continue }
            holderView.addSubview(tempViewArray[i])
            tempViewArray[i].heightAnchor.constraint(equalToConstant: sensorHeight).isActive = true
            tempViewArray[i].widthAnchor.constraint(equalToConstant: sensorWidth).isActive = true

            if i < 3 {

                tempViewArray[i].topAnchor.constraint(equalTo: holderView.topAnchor).isActive = true
                if i == 0 {
                    tempViewArray[i].leadingAnchor.constraint(equalTo: holderView.leadingAnchor).isActive = true
                    addDataToSensorView(withView: sensorView, withImage: #imageLiteral(resourceName: "ic_saifon_carbonmonoxide.png"), type: "Carbon monoxide", value: "22.89 PPM")
                } else {

                    if i % 2 == 0 {
                        tempViewArray[i].trailingAnchor.constraint(equalTo: holderView.trailingAnchor).isActive = true
                        addDataToSensorView(withView: sensorView, withImage: #imageLiteral(resourceName: "ic_saifon_rain_gauge.png"), type: "Rain gauge", value: "22.89 PPM")
                    } else {
                        tempViewArray[i].leadingAnchor.constraint(equalTo: tempViewArray[i - 1].trailingAnchor).isActive = true
                        addDataToSensorView(withView: sensorView, withImage: #imageLiteral(resourceName: "ic_saifon_pressure.png"), type: "Pressure", value: "22.89 PPM")
                    }
                }
            } else {

                tempViewArray[i].topAnchor.constraint(equalTo: tempViewArray[0].bottomAnchor).isActive = true
                if i == 3 {
                    tempViewArray[i].leadingAnchor.constraint(equalTo: holderView.leadingAnchor).isActive = true
                    addDataToSensorView(withView: sensorView, withImage: #imageLiteral(resourceName: "ic_saifon_pm10.png"), type: "PM2.5", value: "22.89 PPM")
                } else {

                    if i % 5 == 0 {
                        tempViewArray[i].trailingAnchor.constraint(equalTo: holderView.trailingAnchor).isActive = true
                    } else {
                        tempViewArray[i].leadingAnchor.constraint(equalTo: tempViewArray[i - 1].trailingAnchor).isActive = true
                        addDataToSensorView(withView: sensorView, withImage: #imageLiteral(resourceName: "ic_saifon_luminousity.png"), type: "Luminosity", value: "22.89 PPM")
                    }
                }
            }
        }
    }
    
    private func addDataToSensorView(withView customView: SensorView, withImage image: UIImage, type: String, value: String) {
        
        let attributedText = NSMutableAttributedString(string: type, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.medium)])
        attributedText.append(NSAttributedString(string: "\n\(value)", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.regular)]))
        customView.imageView.image = image
        customView.descriptionTextview.attributedText = attributedText
        customView.descriptionTextview.textAlignment = .center
        customView.layoutIfNeeded()
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
        tv.isScrollEnabled = false
        tv.isEditable = false
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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







