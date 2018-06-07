//
//  SaifonAboutCell.swift
//  dashboardKB
//
//  Created by Hainizam on 21/02/2018.
//  Copyright © 2018 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

protocol SaifonAboutProtocol: class {
    func contactCareline(withInfo info: Careline)
}

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
    
    weak var delegate: SaifonAboutProtocol?
    var careline: [Careline] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("CollectionView Size: ", frame.size)
        setupAutoLayout()
        populateData()
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
    
    private func populateData() {
        
        careline.append(Careline(name: "Pejabat Daerah - Kota Belud", email: "ipj1@saifon.my", phoneNumber: "088976542"))
        careline.append(Careline(name: "APM - Kota Belud", email: "apm1@saifon.my", phoneNumber: "088976542"))
        careline.append(Careline(name: "PDRM Sabah - Kota Belud", email: "ipj1@saifon.my", phoneNumber: "088976542"))
        careline.append(Careline(name: "Balai Bomba dan Penyelamat", email: "ipj1@saifon.my", phoneNumber: "088976542"))
        careline.append(Careline(name: "Jabatan Kerja Raya (JKR)", email: "ipj1@saifon.my", phoneNumber: "088976542"))
        careline.append(Careline(name: "Jabatan Pengairan dan Saliran (JPS)", email: "jps1@saifon.my", phoneNumber: "088976542"))
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
        return careline.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SaifonIdentifier.AboutCell, for: indexPath) as! EmergencyInfoCell
        cell.selectionStyle = .none
        cell.updateCell(withInfo: careline[indexPath.row])
        return cell
    }
}

extension SaifonAboutCell: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let _ = tableView.cellForRow(at: indexPath) as? EmergencyInfoCell else { return }
        let index = indexPath.row
        self.delegate?.contactCareline(withInfo: careline[index])
    }
}













