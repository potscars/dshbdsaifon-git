//
//  SaifonAboutCell.swift
//  dashboardKB
//
//  Created by Hainizam on 21/02/2018.
//  Copyright © 2018 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class SaifonAboutCell: UICollectionViewCell {
    
    lazy var aboutTableview: UITableView = {
        
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(EmergencyInfoCell.self, forCellReuseIdentifier: SaifonIdentifier.AboutCell)
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
        
        addSubview(aboutTableview)
        
        aboutTableview.topAnchor.constraint(equalTo: topAnchor).isActive = true
        aboutTableview.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        aboutTableview.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        aboutTableview.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        aboutTableview.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        print("RIVERTABLE: ", aboutTableview.frame.size)
    }
}

extension SaifonAboutCell: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SaifonIdentifier.AboutCell, for: indexPath) as! EmergencyInfoCell
        cell.selectionStyle = .none
        
        return cell
    }
}

extension SaifonAboutCell: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 64.0
    }
}













