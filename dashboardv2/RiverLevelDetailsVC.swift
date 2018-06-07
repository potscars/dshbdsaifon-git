//
//  RiverLevelDetailsVC.swift
//  dashboardKB
//
//  Created by Hainizam on 03/05/2018.
//  Copyright © 2018 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class RiverLevelDetailsVC: UIViewController {

    //iboulet for river level indicator
    @IBOutlet weak var dangerTextview: UITextView!
    @IBOutlet weak var warningTextview: UITextView!
    @IBOutlet weak var cautionTextview: UITextView!
    
    //current river level, and the difference with previous
    @IBOutlet weak var currenRivertLevelLabel: UILabel!
    @IBOutlet weak var differencesLevelLabel: UILabel!
    @IBOutlet weak var previousRiverLevelLabel: UILabel!
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var indicatorStackViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var holderViewConstraint: NSLayoutConstraint!
    
    var holderViewConstraintConstant: CGFloat {
        return self.view.frame.height * 0.25
    }
    
    var indicatorStackViewConstraintConstant: CGFloat {
        return self.holderViewConstraintConstant * 0.20
    }
    
    var fontSizeForIndicator: CGFloat {
        return indicatorStackViewConstraintConstant * 0.30
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureConstraint()
        configureRiverLevelIndicator()
    }
    
    private func configureConstraint() {
        navigationBar.delegate = self
        navigationBar.tintColor = UIColor.white
        navigationBar.barTintColor = UIColor.lightBlue
        holderViewConstraint.constant = holderViewConstraintConstant
        indicatorStackViewConstraint.constant = indicatorStackViewConstraintConstant
    }
    
    private func configureRiverLevelIndicator() {
        
        let dangerAttributedText = NSMutableAttributedString(string: "Bahaya", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: fontSizeForIndicator, weight: UIFont.Weight.medium)])
        dangerAttributedText.append(NSAttributedString(string: "\n5.5m", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: fontSizeForIndicator, weight: UIFont.Weight.medium)]))
        dangerTextview.attributedText = dangerAttributedText
        dangerTextview.textAlignment = .center
        dangerTextview.textColor = .white
        dangerTextview.textContainerInset = UIEdgeInsetsMake(2, 8, 2, 8)
        
        let warningAttributedText = NSMutableAttributedString(string: "Amaran", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: fontSizeForIndicator, weight: UIFont.Weight.medium)])
        warningAttributedText.append(NSAttributedString(string: "\n4.7m", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: fontSizeForIndicator, weight: UIFont.Weight.medium)]))
        warningTextview.attributedText = warningAttributedText
        warningTextview.textAlignment = .center
        warningTextview.textColor = .white
        warningTextview.textContainerInset = UIEdgeInsetsMake(2, 8, 2, 8)
        
        let attributedText = NSMutableAttributedString(string: "Berjaga", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: fontSizeForIndicator, weight: UIFont.Weight.medium)])
        attributedText.append(NSAttributedString(string: "\n4.3m", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: fontSizeForIndicator, weight: UIFont.Weight.medium)]))
        cautionTextview.attributedText = attributedText
        cautionTextview.textAlignment = .center
        cautionTextview.textContainerInset = UIEdgeInsetsMake(2, 8, 2, 8)
    }
    @IBAction func closeDetails(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension RiverLevelDetailsVC: UINavigationBarDelegate {
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}
















