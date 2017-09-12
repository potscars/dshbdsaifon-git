//
//  MyPlaceFilterVC.swift
//  dashboardKB
//
//  Created by Hainizam on 05/06/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MyPlaceFilterVC: UITableViewController {

    //MARK: - outlet
    
    struct Storyboard {
        
        static let sortHeader = "sortHeaderCell"
        static let sortCell = "sortCell"
        static let filterHeader = "filterHeaderCell"
        static let filterCell = "filterCell"
        static let buttonCell = "filterButtonCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.barTintColor = UIColor.orange
        navigationController?.navigationBar.tintColor = UIColor.white
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.estimatedRowHeight = 143.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }

}

// MARK: - Table view data source
extension MyPlaceFilterVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        let index = indexPath.item
        
        if index == 0 {
            
            cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.sortHeader)! as UITableViewCell
            
            return cell
        } else if index == 1 {
            
            cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.sortCell)! as! SortOptionsCell
            
            return cell
        } else if index == 2 {
            
            cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.filterHeader)! as UITableViewCell
            
            return cell
        } else if index == 3 {
            
            cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.filterCell)! as! FilterOptionsCell
            
            return cell
        } else if index == 4 {
            
            cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.buttonCell)! as UITableViewCell
            
            return cell
        } else {
            
        }
        
        return cell
    }
}

extension MyPlaceFilterVC {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}












