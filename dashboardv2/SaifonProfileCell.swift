//
//  SaifonProfileCell.swift
//  dashboardKB
//
//  Created by Hainizam on 12/04/2018.
//  Copyright © 2018 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class SaifonProfileCell: UICollectionViewCell {
    lazy var profileTableView: UITableView = {
        
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ProfileSettingsCell.self, forCellReuseIdentifier: SaifonIdentifier.ProfileMenuCell)
        tableView.autoresizesSubviews = true
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.separatorStyle = .none
        return tableView
    }()
    
    var profileHeader = ProfileHeaderView()
    var profileMenus = [ProfileMenu]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addingProfileMenu()
        setupAutoLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupAutoLayout() {
        
        addSubview(profileTableView)
        
        profileTableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        profileTableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        profileTableView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        profileTableView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        profileTableView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileTableView.tableHeaderView = profileHeader
        let customHeaderFrame = CGSize(width: self.bounds.width, height: self.bounds.height * 0.3)
        profileTableView.tableHeaderView?.frame.size = customHeaderFrame
    }
    
    private func addingProfileMenu() {
        
        profileMenus.append(ProfileMenu(category: "Account Settings", submenu: ["Edit profile", "Change password", "Logout"]))
        profileMenus.append(ProfileMenu(category: "Notification Setting", submenu: ["Mute notification"]))
    }
}

extension SaifonProfileCell: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return profileMenus.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileMenus[section].submenu.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return profileMenus[section].category
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SaifonIdentifier.ProfileMenuCell, for: indexPath) as? ProfileSettingsCell else { return UITableViewCell() }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
}

struct ProfileMenu {
    let category: String
    let submenu: [String]
}








