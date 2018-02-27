//
//  SaifonMainVC.swift
//  dashboardKB
//
//  Created by Hainizam on 14/02/2018.
//  Copyright © 2018 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

struct SaifonIdentifier {
    
    static let MenuBarCell = "menuBarCellIdentifier"
    static let SaifonBottomSheetVC = "SaifonBottomSheetVC"
    static let DetailsView = "detailsViewCell"
    static let AnnouncementView = "announcementsViewCell"
    static let AboutView = "aboutViewCell"
    static let SummaryTableViewCell = "summaryCell"
    static let SensorTableViewCell = "sensorCell"
    static let RiverLevelTableViewCell = "riverLevelCell"
    static let AnnouncementContentCell = "announcementContentCell"
    static let AboutCell = "aboutCell"
}

class SaifonMainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addBottomSheet()
    }
    
    func addBottomSheet() {
        
        let storyboard = UIStoryboard(name: "Saifon", bundle: nil)
        guard let bottomVC = storyboard.instantiateViewController(withIdentifier: SaifonIdentifier.SaifonBottomSheetVC) as? SaifonBottomSheetVC else { return }
        
        self.addChildViewController(bottomVC)
        self.view.addSubview(bottomVC.view)
        bottomVC.didMove(toParentViewController: self)
        
        let height = self.view.frame.height
        let width = self.view.frame.width
        bottomVC.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
    }
}














