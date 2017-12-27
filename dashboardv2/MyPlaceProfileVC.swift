//
//  MyPlaceProfileVC.swift
//  dashboardKB
//
//  Created by Mohd Zulhilmi Mohd Zain on 13/04/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MyPlaceProfileVC: UIViewController {
    
    @IBOutlet weak var tableView: MyPlaceProfileHistoryTV!
    
    @IBOutlet weak var uiivMPPHTVProfilePic: UIImageView!
    @IBOutlet weak var uilMPPHTVProfileName: UILabel!
    @IBOutlet weak var uilMPPHTVProfileLocation: UILabel!
    @IBOutlet weak var uilMPPHTVProfileCreated: UILabel!
    @IBOutlet weak var profileViewConstraints: NSLayoutConstraint!
    @IBOutlet weak var profileView: UIView!
    
    let profileData: NSDictionary = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.profileVC = self
        
        self.configureNavBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let homeImage = UIImage(named: "ic_home_white")
        let homeButton = UIBarButtonItem(image: homeImage, style: .done, target: self, action: #selector(dismissMyPlace))
        
        self.navigationItem.rightBarButtonItem = homeButton
    }
    
    @objc func dismissMyPlace() {
        
        dismiss(animated: true, completion: nil)
    }
    
    func configureNavBar() {
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barTintColor = DBColorSet.myPlacePrimaryColor
        title = "My Profile"
    }
    
    func changeViewDisplayed(_ viewHeight: CGFloat) {
        
        self.profileViewConstraints?.constant = viewHeight
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.profileView?.layoutIfNeeded()
        }, completion: nil)
    }
}













