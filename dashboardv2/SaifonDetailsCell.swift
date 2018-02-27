//
//  SaifonDetailsCell.swift
//  dashboardKB
//
//  Created by Hainizam on 14/02/2018.
//  Copyright © 2018 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class SaifonDetailsCell: UICollectionViewCell {
    
    lazy var riverTableView: UITableView = {
       
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(DetailsSummaryCell.self, forCellReuseIdentifier: SaifonIdentifier.SummaryTableViewCell)
        tableView.register(DetailsSensorCell.self, forCellReuseIdentifier: SaifonIdentifier.SensorTableViewCell)
        tableView.register(DetailsRiverLevelCell.self, forCellReuseIdentifier: SaifonIdentifier.RiverLevelTableViewCell)
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
        
        addSubview(riverTableView)
        
        riverTableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        riverTableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        riverTableView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        riverTableView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        
        riverTableView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        print("RIVERTABLE: ", riverTableView.frame.size)
    }
}

extension SaifonDetailsCell: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /*
         0 - summary cell
         1 - sensor cell
         2.. - river level cell
 
         */
        
        let index = indexPath.row
        
        if index == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SaifonIdentifier.SummaryTableViewCell, for: indexPath) as! DetailsSummaryCell
            cell.selectionStyle = .none
            
            return cell
        } else if index == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: SaifonIdentifier.SensorTableViewCell, for: indexPath) as! DetailsSensorCell
            cell.selectionStyle = .none
            
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: SaifonIdentifier.RiverLevelTableViewCell, for: indexPath) as! DetailsRiverLevelCell
            cell.selectionStyle = .none
            
            return cell
        }
    }
}

extension SaifonDetailsCell: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let index = indexPath.row
        
        if index == 0 {
            return 230.0
        } else if index == 1 {
            return 200.0
        } else {
            return 306.0
        }
    }
}















