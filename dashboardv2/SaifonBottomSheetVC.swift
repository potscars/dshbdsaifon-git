//
//  SaifonBottomSheetVC.swift
//  dashboardKB
//
//  Created by Hainizam on 14/02/2018.
//  Copyright © 2018 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class SaifonBottomSheetVC: UIViewController {
    
    @IBOutlet weak var menuBar: SaifonBottomSheetMenuBarCVC!
    @IBOutlet weak var contentCollectionView: UICollectionView!
    @IBOutlet weak var holderView: UIView!
    
    var fullViewY: CGFloat = 44
    var initialView: CGFloat {
        return UIScreen.main.bounds.height * 0.6
    }
    var didPerformFirstAnimation = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkBlue   
        setupCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupCollectionView() {
        
        menuBar.menuBarDelegate = self
        contentCollectionView.dataSource = self
        contentCollectionView.delegate = self
        contentCollectionView.isPagingEnabled = true
        contentCollectionView.backgroundColor = .superLightGray
        
        let layout = contentCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .horizontal
        layout.itemSize = self.contentCollectionView.bounds.size
        
        //register cell for uicollectionview bottom sheet
        contentCollectionView.register(SaifonDetailsCell.self, forCellWithReuseIdentifier: SaifonIdentifier.DetailsView)
        contentCollectionView.register(SaifonAnnouncementCell.self, forCellWithReuseIdentifier: SaifonIdentifier.AnnouncementView)
        contentCollectionView.register(SaifonNotificationCell.self, forCellWithReuseIdentifier: SaifonIdentifier.NotificationView)
        contentCollectionView.register(SaifonAboutCell.self, forCellWithReuseIdentifier: SaifonIdentifier.AboutView)
        contentCollectionView.register(SaifonProfileCell.self, forCellWithReuseIdentifier: SaifonIdentifier.ProfileView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

extension SaifonBottomSheetVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let index = indexPath.item
        
        if index == 0 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SaifonIdentifier.DetailsView, for: indexPath) as! SaifonDetailsCell
            cell.delegate = self
            return cell
        } else if index == 1 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SaifonIdentifier.AnnouncementView, for: indexPath) as! SaifonAnnouncementCell
            cell.announcementDelegate = self
            return cell
        } else if index == 2 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SaifonIdentifier.AboutView, for: indexPath) as! SaifonAboutCell
            cell.delegate = self
            return cell
        } else if index == 3 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SaifonIdentifier.NotificationView, for: indexPath) as! SaifonNotificationCell
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SaifonIdentifier.ProfileView, for: indexPath) as! SaifonProfileCell
            
            return cell
        }
    }
}

extension SaifonBottomSheetVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        let height: CGFloat = self.contentCollectionView.frame.height
        let width: CGFloat = self.contentCollectionView.frame.width
        
        return CGSize(width: width, height: height)
    }
    
    //swipe content cell, akan tukar kan menubar title jugak.
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let itemWidth = collectionView(contentCollectionView, layout: contentCollectionView.collectionViewLayout, sizeForItemAt: IndexPath(item: 0, section: 0)).width

        let offset = targetContentOffset.pointee
        let index = (offset.x + contentCollectionView.contentInset.left) / itemWidth
        let roundedIndex = round(index)
        
        let page: CGFloat
        if round(index + 0.3) == round(index) {
            page = round(index)
        }
        else {
            page = round(index) + 1
        }
        
        menuBar.titleIndex = Int(page)
        menuBar.scrollToItem(at: IndexPath(item: Int(roundedIndex), section: 0), at: .centeredHorizontally, animated: true)
        menuBar.reloadData()
    }
}

extension SaifonBottomSheetVC: SaifonMenuBarDelegate {
    
    func scrollToMenuIndex(toIndex index: Int) {
        
        let indexPath = IndexPath(item: index, section: 0)
        contentCollectionView?.scrollToItem(at: indexPath, at: [], animated: true)
    }
}

extension SaifonBottomSheetVC: SaifonAnnouncementDelegate {
    
    func didTappedCell() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: SaifonIdentifier.AnnouncementDetailsSegue, sender: nil)
        }
    }
}

extension SaifonBottomSheetVC: SaifonAboutProtocol {
    func contactCareline(withInfo info: Careline) {
        
        let alertSheet = UIAlertController(title: "Hubungi \(info.name)", message: "Sila pilih jenis perhubungan", preferredStyle: .actionSheet)
        let emailAction = UIAlertAction(title: info.email, style: .default, handler: nil)
        let phoneAction = UIAlertAction(title: "85588630", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Batal", style: .cancel, handler: nil)
        
        alertSheet.addAction(emailAction)
        alertSheet.addAction(phoneAction)
        alertSheet.addAction(cancelAction)
        
        DispatchQueue.main.async {
            self.present(alertSheet, animated: true, completion: nil)
        }
    }
}

extension SaifonBottomSheetVC: SaifonDetailsProtocol {
    func openRiverDetails() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "SaifonRiverDetails", sender: nil)
        }
    }
}















