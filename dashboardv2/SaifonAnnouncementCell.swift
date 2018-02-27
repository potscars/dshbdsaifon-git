//
//  SaifonAnnouncementCell.swift
//  dashboardKB
//
//  Created by Hainizam on 20/02/2018.
//  Copyright © 2018 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class SaifonAnnouncementCell: UICollectionViewCell {
    
    lazy var announcementContentTableview: UITableView = {
        
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(AnnouncementContentCell.self, forCellReuseIdentifier: SaifonIdentifier.AnnouncementContentCell)
        tableView.autoresizesSubviews = true
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("CollectionView Size: ", frame.size)
        setupAutoLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupAutoLayout() {
        
        addSubview(announcementContentTableview)
        
        announcementContentTableview.topAnchor.constraint(equalTo: topAnchor).isActive = true
        announcementContentTableview.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        announcementContentTableview.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        announcementContentTableview.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        announcementContentTableview.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        print("RIVERTABLE: ", announcementContentTableview.frame.size)
    }
}

extension SaifonAnnouncementCell: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SaifonIdentifier.AnnouncementContentCell, for: indexPath) as! AnnouncementContentCell
        cell.selectionStyle = .none
        
        return cell
    }
}

extension SaifonAnnouncementCell: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 260.0
    }
}





