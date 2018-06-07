//
//  ListImagesTVC.swift
//  dashboardKB
//
//  Created by Hainizam on 24/04/2018.
//  Copyright © 2018 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class ListImagesTVC: UITableViewController {

    var imageNames = ["scenery1", "scenery2", "scenery3", "scenery4", "scenery5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.estimatedRowHeight = 250.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return imageNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell") else { return UITableViewCell() }
        
//        let iv = cell.viewWithTag(1) as! UIImageView
//        iv.contentMode = .scaleAspectFill
//        iv.image = UIImage(named: imageNames[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}













