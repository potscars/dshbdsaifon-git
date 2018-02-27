//
//  DetailsSummaryCell.swift
//  dashboardKB
//
//  Created by Hainizam on 14/02/2018.
//  Copyright © 2018 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class DetailsSummaryCell: UITableViewCell {
    
    let holderView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.autoresizesSubviews = true
        return view
    }()
    
    let venueInfoTextview: UITextView = {
        
        var tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        
        var attributedText = NSMutableAttributedString(string: "Bentong, Pahang", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium)])
        attributedText.append(NSAttributedString(string: "\nFriday 5:00 PM", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.regular)]))
        attributedText.append(NSAttributedString(string: "\nRain", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)]))
        tv.attributedText = attributedText
        
        tv.isScrollEnabled = false
        tv.isEditable = false
        tv.textAlignment = .left
        
        return tv
    }()
    
    let cloudImageView: UIImageView = {
       
        var iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "default_avatar")
        iv.clipsToBounds = true
        return iv
    }()
    
    let maxRainLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Max 27'"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        return label
    }()
    
    let minRainLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Min 27'"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        return label
    }()
    
    //the bottom half of summarry views.
    let windDirectionView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.autoresizesSubviews = true
        return view
    }()
    
    let windDirectionImageView: UIImageView = {
        var iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "default_avatar")
        iv.clipsToBounds = true
        return iv
    }()
    
    let windDirectionTextview: UITextView = {
       let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        
        var attributedText = NSMutableAttributedString(string: "Wind Direction", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.medium)])
        attributedText.append(NSAttributedString(string: "\nNW", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)]))
        tv.attributedText = attributedText
        
        tv.isScrollEnabled = false
        tv.isEditable = false
        tv.textAlignment = .center
        return tv
    }()
    
    let windSpeedView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.autoresizesSubviews = true
        return view
    }()
    
    let windSpeedImageView: UIImageView = {
        var iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "default_avatar")
        iv.clipsToBounds = true
        return iv
    }()
    
    let windSpeedTextview: UITextView = {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        
        var attributedText = NSMutableAttributedString(string: "Wind Speed", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.medium)])
        attributedText.append(NSAttributedString(string: "\n4 kph", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)]))
        tv.attributedText = attributedText
        
        tv.isScrollEnabled = false
        tv.isEditable = false
        tv.textAlignment = .center
        return tv
    }()
    
    let humidityView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .yellow
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.autoresizesSubviews = true
        return view
    }()
    
    let humidityImageView: UIImageView = {
        var iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.image = #imageLiteral(resourceName: "default_avatar")
        iv.clipsToBounds = true
        return iv
    }()
    
    let humidityTextview: UITextView = {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        
        var attributedText = NSMutableAttributedString(string: "Humidity", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.medium)])
        attributedText.append(NSAttributedString(string: "\n58.3%", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)]))
        tv.attributedText = attributedText
        
        tv.isScrollEnabled = false
        tv.isEditable = false
        tv.textAlignment = .center
        return tv
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .lightGray
        contentView.backgroundColor = .black
        setupAutoLayoutForHolderView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        print(contentView.frame.size, holderView.bounds.size)
        setupAutoLayout()
    }
    
    private func setupAutoLayoutForHolderView() {
        contentView.addSubview(holderView)
        
        holderView.topAnchor.constraint(equalTo: topAnchor, constant: 8.0).isActive = true
        holderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8.0).isActive = true
        holderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8.0).isActive = true
        holderView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0).isActive = true
    }
    
    func setupAutoLayout() {
        
        holderView.addSubview(venueInfoTextview)
        
        let venueInfoWidth = contentView.frame.width * 0.6
        let venueInfoHeight = (contentView.frame.height - 16) * 0.6
        
        venueInfoTextview.topAnchor.constraint(equalTo: holderView.topAnchor).isActive = true
        venueInfoTextview.leftAnchor.constraint(equalTo: holderView.leftAnchor).isActive = true
        venueInfoTextview.heightAnchor.constraint(equalToConstant: venueInfoHeight).isActive = true
        venueInfoTextview.widthAnchor.constraint(equalToConstant: venueInfoWidth).isActive = true
        
        holderView.addSubview(cloudImageView)
        
        cloudImageView.topAnchor.constraint(equalTo: holderView.topAnchor).isActive = true
        cloudImageView.leftAnchor.constraint(equalTo: venueInfoTextview.rightAnchor).isActive = true
        cloudImageView.rightAnchor.constraint(equalTo: holderView.rightAnchor).isActive = true
        cloudImageView.heightAnchor.constraint(equalToConstant: venueInfoHeight * 0.7).isActive = true
        
        holderView.addSubview(maxRainLabel)
        holderView.addSubview(minRainLabel)
        
        //set anchor for maxlabel first.
        maxRainLabel.topAnchor.constraint(equalTo: cloudImageView.bottomAnchor).isActive = true
        maxRainLabel.leftAnchor.constraint(equalTo: venueInfoTextview.rightAnchor).isActive = true
        maxRainLabel.heightAnchor.constraint(equalToConstant: venueInfoHeight * 0.3).isActive = true
        
        //then set minlabel
        minRainLabel.topAnchor.constraint(equalTo: cloudImageView.bottomAnchor).isActive = true
        minRainLabel.rightAnchor.constraint(equalTo: holderView.rightAnchor).isActive = true
        minRainLabel.heightAnchor.constraint(equalToConstant: venueInfoHeight * 0.3).isActive = true
        
        maxRainLabel.trailingAnchor.constraint(equalTo: minRainLabel.leadingAnchor).isActive = true
        //equal kan width dua label ni.
        maxRainLabel.widthAnchor.constraint(equalTo: minRainLabel.widthAnchor).isActive = true
        maxRainLabel.widthAnchor.constraint(equalTo: minRainLabel.widthAnchor).isActive = true
        
        
        setupAutoLayoutForBottomHalf()
    }
    
    private func setupAutoLayoutForBottomHalf() {
        
        holderView.addSubview(windDirectionView)
        holderView.addSubview(windSpeedView)
        holderView.addSubview(humidityView)
        
        let onePerThreeWidth = (contentView.frame.width - 16) / 3
        
        windDirectionView.topAnchor.constraint(equalTo: venueInfoTextview.bottomAnchor).isActive = true
        windDirectionView.leftAnchor.constraint(equalTo: holderView.leftAnchor).isActive = true
        windDirectionView.heightAnchor.constraint(equalTo: holderView.heightAnchor, multiplier: 0.4).isActive = true
        windDirectionView.widthAnchor.constraint(equalToConstant: onePerThreeWidth).isActive = true
        
        windSpeedView.topAnchor.constraint(equalTo: venueInfoTextview.bottomAnchor).isActive = true
        windSpeedView.leftAnchor.constraint(equalTo: windDirectionView.rightAnchor).isActive = true
        windSpeedView.heightAnchor.constraint(equalTo: holderView.heightAnchor, multiplier: 0.4).isActive = true
        windSpeedView.widthAnchor.constraint(equalTo: windDirectionView.widthAnchor).isActive = true
        
        humidityView.topAnchor.constraint(equalTo: venueInfoTextview.bottomAnchor).isActive = true
        humidityView.rightAnchor.constraint(equalTo: holderView.rightAnchor).isActive = true
        humidityView.heightAnchor.constraint(equalTo: holderView.heightAnchor, multiplier: 0.4).isActive = true
        humidityView.widthAnchor.constraint(equalTo: windDirectionView.widthAnchor).isActive = true
        
        //winddirection punya autolayout.
        windDirectionView.addSubview(windDirectionImageView)
        windDirectionView.addSubview(windDirectionTextview)
        
        let imageVieMultiplier: CGFloat = 0.35
        
        windDirectionImageView.centerXAnchor.constraint(equalTo: windDirectionView.centerXAnchor).isActive = true
        windDirectionImageView.topAnchor.constraint(equalTo: windDirectionView.topAnchor, constant: 0.0).isActive = true
        windDirectionImageView.heightAnchor.constraint(equalTo: windDirectionView.heightAnchor, multiplier: imageVieMultiplier).isActive = true
        windDirectionImageView.widthAnchor.constraint(equalTo: windDirectionView.heightAnchor, multiplier: imageVieMultiplier).isActive = true
        
        windDirectionTextview.topAnchor.constraint(equalTo: windDirectionImageView.bottomAnchor, constant: 8.0).isActive = true
        windDirectionTextview.leftAnchor.constraint(equalTo: windDirectionView.leftAnchor, constant: 8.0).isActive = true
        windDirectionTextview.rightAnchor.constraint(equalTo: windDirectionView.rightAnchor, constant: -8.0).isActive = true
        windDirectionTextview.bottomAnchor.constraint(equalTo: windDirectionView.bottomAnchor, constant: -4.0).isActive = true
        
        //windspeed punya autolayout.
        windSpeedView.addSubview(windSpeedImageView)
        windSpeedView.addSubview(windSpeedTextview)
        
        windSpeedImageView.centerXAnchor.constraint(equalTo: windSpeedView.centerXAnchor).isActive = true
        windSpeedImageView.topAnchor.constraint(equalTo: windSpeedView.topAnchor, constant: 0.0).isActive = true
        windSpeedImageView.heightAnchor.constraint(equalTo: windSpeedView.heightAnchor, multiplier: imageVieMultiplier).isActive = true
        windSpeedImageView.widthAnchor.constraint(equalTo: windSpeedView.heightAnchor, multiplier: imageVieMultiplier).isActive = true
        
        windSpeedTextview.topAnchor.constraint(equalTo: windSpeedImageView.bottomAnchor, constant: 8.0).isActive = true
        windSpeedTextview.leftAnchor.constraint(equalTo: windSpeedView.leftAnchor, constant: 8.0).isActive = true
        windSpeedTextview.rightAnchor.constraint(equalTo: windSpeedView.rightAnchor, constant: -8.0).isActive = true
        windSpeedTextview.bottomAnchor.constraint(equalTo: windSpeedView.bottomAnchor, constant: -4.0).isActive = true
        
        humidityView.addSubview(humidityImageView)
        humidityView.addSubview(humidityTextview)
        
        humidityImageView.centerXAnchor.constraint(equalTo: humidityView.centerXAnchor).isActive = true
        humidityImageView.topAnchor.constraint(equalTo: humidityView.topAnchor, constant: 0.0).isActive = true
        humidityImageView.heightAnchor.constraint(equalTo: humidityView.heightAnchor, multiplier: imageVieMultiplier).isActive = true
        humidityImageView.widthAnchor.constraint(equalTo: humidityView.heightAnchor, multiplier: imageVieMultiplier).isActive = true
        
        humidityTextview.topAnchor.constraint(equalTo: humidityImageView.bottomAnchor, constant: 8.0).isActive = true
        humidityTextview.leftAnchor.constraint(equalTo: humidityView.leftAnchor, constant: 8.0).isActive = true
        humidityTextview.rightAnchor.constraint(equalTo: humidityView.rightAnchor, constant: -8.0).isActive = true
        humidityTextview.bottomAnchor.constraint(equalTo: humidityView.bottomAnchor, constant: -4.0).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}















