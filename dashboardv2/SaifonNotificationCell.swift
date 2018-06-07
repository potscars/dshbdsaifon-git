//
//  SaifonNotificationCell.swift
//  dashboardKB
//
//  Created by Hainizam on 12/04/2018.
//  Copyright © 2018 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class SaifonNotificationCell: UICollectionViewCell {
    
    lazy var notificationTableView: UITableView = {
        
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(NotificationCell.self, forCellReuseIdentifier: SaifonIdentifier.NotificationCell)
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
        
        addSubview(notificationTableView)
        
        notificationTableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        notificationTableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        notificationTableView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        notificationTableView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        notificationTableView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

extension SaifonNotificationCell: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SaifonIdentifier.NotificationCell, for: indexPath) as? NotificationCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}














