//
//  SaifonMainVC.swift
//  dashboardKB
//
//  Created by Hainizam on 14/02/2018.
//  Copyright © 2018 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
import GoogleMaps

struct SaifonIdentifier {
    
    static let MenuBarCell = "menuBarCellIdentifier"
    static let SaifonBottomSheetVC = "SaifonBottomSheetVC"
    static let DetailsView = "detailsViewCell"
    static let AnnouncementView = "announcementsViewCell"
    static let AnnouncementDetailsVC = "AnnouncementDetailsVC"
    static let AnnouncementDetailsSegue = "AnnouncementDetailsSegue"
    static let AboutView = "aboutViewCell"
    static let SummaryTableViewCell = "summaryCell"
    static let SensorTableViewCell = "sensorCell"
    static let RiverLevelTableViewCell = "riverLevelCell"
    static let AnnouncementContentCell = "announcementContentCell"
    static let AboutCell = "aboutCell"
    static let NotificationView = "notificationViewCell"
    static let NotificationCell = "notificationTableViewCell"
    static let ProfileView = "profileViewCell"
    static let ProfileMenuCell = "profileMenuCell"
}

class SaifonMainVC: UIViewController, UICollisionBehaviorDelegate {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.default
    }
    
    //MARK: - Properties
    var previousTouchPoint:CGPoint!
    var viewDragging = false
    var viewPinned = false
    var isBottomSheetAdded = false
    var fullViewY: CGFloat = 20
    var initialView: CGFloat {
        return UIScreen.main.bounds.height * 0.6
    }
    
    //MARK: - IBOutlet
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !isBottomSheetAdded {
            isBottomSheetAdded = !isBottomSheetAdded
            addBottomSheet()
        }
        
        configureLabel()
        configureMapView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = preferredStatusBarStyle
    }
    
    private func configureLabel() {
        
        titleLabel.textColor = .white
        titleLabel.addShadow()
    }
    
    private func configureMapView() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 12.0)
        mapView.camera = camera
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        
        let pinMarkers = [PinMarker(name: "Sydney1", latitude: -33.85, longitude: 151.20),
                         PinMarker(name: "Sydney2", latitude: -33.8543, longitude: 151.1954),
                         PinMarker(name: "Sydney3", latitude: -33.8422, longitude: 151.2013),
                         PinMarker(name: "Sydney4", latitude: -33.8034, longitude: 151.2103),
                         PinMarker(name: "Sydney5", latitude: -33.8576, longitude: 151.20),
                         PinMarker(name: "Sydney6", latitude: -33.849, longitude: 151.20)]
        
        for pinMarker in pinMarkers {
            
            let stateMarker = GMSMarker()
            stateMarker.position = CLLocationCoordinate2D(latitude: pinMarker.latitude, longitude: pinMarker.longitude)
            stateMarker.title = pinMarker.name
            stateMarker.snippet = "Hey, this is \(pinMarker.name)"
            stateMarker.map = mapView
        }
    }
    
    func addBottomSheet() {
        
        let frameForView = self.view.bounds.offsetBy(dx: 0, dy: initialView)
        
        let storyboard = UIStoryboard(name: "Saifon", bundle: nil)
        guard let bottomVC = storyboard.instantiateViewController(withIdentifier: SaifonIdentifier.SaifonBottomSheetVC) as? SaifonBottomSheetVC else { return }
        
        guard let view = bottomVC.view else { return }
        view.layer.cornerRadius = 5
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.5
        
        print("MAXY: ", self.view.frame.maxY)
        bottomVC.view.frame = frameForView
        
        self.addChildViewController(bottomVC)
        self.view.addSubview(bottomVC.view)
        bottomVC.didMove(toParentViewController: self)
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gestureRecognizer:)))
        view.addGestureRecognizer(gesture)
    }
    
    @objc func handlePan (gestureRecognizer:UIPanGestureRecognizer) {

        let draggedView = gestureRecognizer.view!
        let translation = gestureRecognizer.translation(in: draggedView)
        let velocity = gestureRecognizer.velocity(in: draggedView)
        let y = draggedView.frame.minY
        
        //code untuk scroll up and down
        if ( y + translation.y >= fullViewY) && (y + translation.y <= initialView ) {
            draggedView.frame = CGRect(x: 0, y: y + translation.y, width: draggedView.frame.width, height: draggedView.frame.height)
            gestureRecognizer.setTranslation(CGPoint.zero, in: draggedView)
        }
        
        if gestureRecognizer.state == .ended {
            
            //kalau velocity negative, maksud dia scroll ke atas.
            var duration =  velocity.y < 0 ? Double((y - fullViewY) / -velocity.y) : Double((initialView - y) / velocity.y )
            
            duration = duration > 1.3 ? 1 : duration
            
            UIView.animate(withDuration: duration, delay: 0.0, options: [.allowUserInteraction], animations: {
                if  velocity.y >= 0 {
                    let frameForView = self.view.bounds.offsetBy(dx: 0, dy: self.initialView)
                    draggedView.frame = frameForView
                } else {
                    let frameForView = self.view.bounds.offsetBy(dx: 0, dy: self.fullViewY)
                    draggedView.frame = frameForView
                }
                
            }, completion: nil)
        }
    }
}














