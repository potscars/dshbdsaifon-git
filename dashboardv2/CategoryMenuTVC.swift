//
//  AccomodationMenuTVC.swift
//  dashboardKB
//
//  Created by Hainizam on 14/06/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

protocol CategoryMenuDelegate: class {
    
    func getCategory(_ category: String);
}

class CategoryMenuTVC: UITableViewController {

    var delegates: CategoryMenuDelegate!
    var categoryList: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        categoryList = ["Accomodation",
                        "Food & Beverages",
                        "Place of Interest"]
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "categoryCell")
    }
}

//MARK: - TableView Datasource

extension CategoryMenuTVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        
        cell.textLabel?.text = categoryList[indexPath.item]
        
        return cell
    }
}

//MARK: - TableView Delegates

extension CategoryMenuTVC {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) {
            
            if cell.accessoryType == .none {
                
                cell.accessoryType = .checkmark
                self.delegates.getCategory(categoryList[indexPath.item])
                
            } else {
                
                cell.accessoryType = .none
                self.delegates.getCategory("")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) {
            
            cell.accessoryType = .none
            self.delegates.getCategory("")
        }
    }
}














































