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
    
    var fullViewY: CGFloat = 0
    var initialView: CGFloat {
        return UIScreen.main.bounds.height * 0.6
    }
    
    var colors: [UIColor] = [.blue, .yellow, .green]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkBlue
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(panGesture(recognizer:)))
        self.view.addGestureRecognizer(gesture)
        
        setupCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            
            guard let frame = self?.view.frame else { return }
            let yComponent = self?.initialView
            self?.view.frame = CGRect(x: 0, y: yComponent!, width: frame.width, height: frame.height)
        }
    }
    
    func setupCollectionView() {
        
        menuBar.menuBarDelegate = self
        contentCollectionView.dataSource = self
        contentCollectionView.delegate = self
        contentCollectionView.isPagingEnabled = true
        
        let layout = contentCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .horizontal
        layout.itemSize = self.contentCollectionView.frame.size
        
        contentCollectionView.register(SaifonDetailsCell.self, forCellWithReuseIdentifier: SaifonIdentifier.DetailsView)
        contentCollectionView.register(SaifonAnnouncementCell.self, forCellWithReuseIdentifier: SaifonIdentifier.AnnouncementView)
        contentCollectionView.register(SaifonAboutCell.self, forCellWithReuseIdentifier: SaifonIdentifier.AboutView)
    }
    
    @objc func panGesture(recognizer: UIPanGestureRecognizer) {
        
        let translation = recognizer.translation(in: self.view)
        let velocity = recognizer.velocity(in: self.view)
        let y = self.view.frame.minY
        if ( y + translation.y >= fullViewY) && (y + translation.y <= initialView ) {
            self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
            recognizer.setTranslation(CGPoint.zero, in: self.view)
        }
        
        if recognizer.state == .ended {
            //kalau velocity negative, maksud dia scroll ke atas.
            var duration =  velocity.y < 0 ? Double((y - fullViewY) / -velocity.y) : Double((initialView - y) / velocity.y )
            
            duration = duration > 1.3 ? 1 : duration
            
            UIView.animate(withDuration: duration, delay: 0.0, options: [.allowUserInteraction], animations: {
                if  velocity.y >= 0 {
                    self.view.frame = CGRect(x: 0, y: self.initialView, width: self.view.frame.width, height: self.view.frame.height)
                } else {
                    self.view.frame = CGRect(x: 0, y: self.fullViewY, width: self.view.frame.width, height: self.view.frame.height)
                }
                
            }, completion: nil)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

extension SaifonBottomSheetVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let index = indexPath.item
        
        if index == 0 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SaifonIdentifier.DetailsView, for: indexPath) as! SaifonDetailsCell
            
            cell.backgroundColor = colors[indexPath.item]
            
            return cell
        } else if index == 1 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SaifonIdentifier.AnnouncementView, for: indexPath) as! SaifonAnnouncementCell
            
            cell.backgroundColor = colors[indexPath.item]
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SaifonIdentifier.AboutView, for: indexPath) as! SaifonAboutCell
            
            cell.backgroundColor = colors[indexPath.item]
            
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
        
        return self.contentCollectionView.frame.size
    }
    
    //swipe content cell, akan tukar kan menubar title jugak.
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let layout = contentCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout
        let cellWidth = layout?.itemSize.width

        let offset = targetContentOffset.pointee
        let index = (offset.x + contentCollectionView.contentInset.left) / cellWidth!
        let roundedIndex = round(index)

        menuBar.titleIndex = Int(roundedIndex)
        menuBar.reloadData()
    }
}

extension SaifonBottomSheetVC: SaifonMenuBarDelegate {
    
    func scrollToMenuIndex(toIndex index: Int) {
        
        let indexPath = IndexPath(item: index, section: 0)
        contentCollectionView?.scrollToItem(at: indexPath, at: [], animated: true)
    }
}















