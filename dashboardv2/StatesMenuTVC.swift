//
//  StatesMenuTVC.swift
//  dashboardKB
//
//  Created by Hainizam on 13/06/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

protocol StatesMenuDelegates: class {
    
    func getStateName(_ state: String);
}

class StatesMenuTVC: UITableViewController {

    var delegates: StatesMenuDelegates!
    var statesList: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        statesList = ["Johor",
                      "Kedah",
                      "Kelantan",
                      "Malacca" ,
                      "Negeri Sembilan",
                      "Pahang",
                      "Penang",
                      "Perak",
                      "Perlis",
                      "Sabah",
                      "Sarawak",
                      "Selangor",
                      "Terengganu"]
        
        tableView.allowsMultipleSelection = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "statesCell")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        
    }
}

//MARK: - TableView datasource

extension StatesMenuTVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statesList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "statesCell", for: indexPath)
        
        cell.textLabel?.text = statesList[indexPath.item]
        cell.selectionStyle = .none
        
        return cell
    }
}

//MARK: - Tableview delegates

extension StatesMenuTVC {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) {
            
            if cell.accessoryType == .none {
            
                cell.accessoryType = .checkmark
                self.delegates.getStateName(statesList[indexPath.item])
            } else {
                
                cell.accessoryType = .none
                self.delegates.getStateName("")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) {
            
            cell.accessoryType = .none
            self.delegates.getStateName("")
        }
    }
}











