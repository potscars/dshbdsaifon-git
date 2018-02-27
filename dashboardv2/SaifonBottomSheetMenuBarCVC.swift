//
//  SaifonBottomSheetMenuBarCVC.swift
//  dashboardKB
//
//  Created by Hainizam on 14/02/2018.
//  Copyright © 2018 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

protocol SaifonMenuBarDelegate {
    func scrollToMenuIndex(toIndex index: Int)
}

class SaifonBottomSheetMenuBarCVC: UICollectionView, UICollectionViewDelegateFlowLayout {
    
    let menuTitles: [String] = ["Details", "Announcement", "About"]
    var menuBarDelegate: SaifonMenuBarDelegate?
    var titleIndex = 0
    
    override func awakeFromNib() {
        dataSource = self
        delegate = self
        
        configureCollectionView()
    }
    
    func configureCollectionView() {
        
        register(SaifonMenuBarTitleCell.self, forCellWithReuseIdentifier: SaifonIdentifier.MenuBarCell)
    }
}

extension SaifonBottomSheetMenuBarCVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SaifonIdentifier.MenuBarCell, for: indexPath) as! SaifonMenuBarTitleCell
        
        let titleColor = indexPath.row == titleIndex ? UIColor.lightPurple : UIColor.lightGray
        
        cell.menuTitle = menuTitles[indexPath.item]
        cell.titleColor = titleColor
        
        return cell
    }
}

extension SaifonBottomSheetMenuBarCVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 0.0
        layout.minimumLineSpacing = 0.0
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        let index = indexPath.item
        let font = UIFont.systemFont(ofSize: 16, weight: .medium)
        let textWidth = menuTitles[index].getStringSize(usingFont: font).width
        let height = frame.height
        let width = textWidth + 16.0
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        var totalWidth: CGFloat = 0.0
        let font = UIFont.systemFont(ofSize: 16, weight: .medium)
        for cellName in menuTitles {
            let textWidth = cellName.getStringSize(usingFont: font).width + 16
            totalWidth += textWidth
        }
        
        let leftInset = (collectionView.frame.width - totalWidth) / 2
        let rightInset = leftInset
        
        return UIEdgeInsetsMake(0, leftInset, 0, rightInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedIndex = indexPath.row
        
        for (key, _) in menuTitles.enumerated() {
            let indexPath = IndexPath(row: key, section: 0)
            let cell = collectionView.cellForItem(at: indexPath) as! SaifonMenuBarTitleCell
            
            let titleColor: UIColor = key == selectedIndex ? .lightPurple : .lightGray
            cell.titleColor = titleColor
        }
        
        self.menuBarDelegate?.scrollToMenuIndex(toIndex: selectedIndex)
    }
}













