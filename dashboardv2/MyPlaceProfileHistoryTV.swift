//
//  MyPlaceProfileHistoryTV.swift
//  dashboardKB
//
//  Created by Mohd Zulhilmi Mohd Zain on 13/04/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

protocol MyPlaceProfileHistroyDelegates {
    func changeViewDisplayed(_ isHide: Bool)
}

class MyPlaceProfileHistoryTV: UITableView {
    
    var searchController: UISearchController!
    var resultController = UITableViewController()
    
    var states: [String]!
    var filteredStates = [String]()
    
    var profileVC: MyPlaceProfileVC?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //Remove the white space on the top of result view
        resultController.edgesForExtendedLayout = .init(rawValue: 0)
        
        dataSource = self
        backgroundColor = UIColor.white
        
        profileVC = MyPlaceProfileVC()
        states = ["San Francisco","New York","San Jose","Chicago","Los Angeles","Austin","Seattle"]
        
        configuringSearchBar()
    }
    
    func configuringSearchBar() {
        
        self.searchController = UISearchController(searchResultsController: resultController)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        profileVC?.definesPresentationContext = true
        
        searchController.searchBar.placeholder = "Search here..."
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        
        resultController.tableView.dataSource = self
        
        tableHeaderView = self.searchController.searchBar
    }

}

extension MyPlaceProfileHistoryTV: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self {
            
            return states.count
        } else {
            
            return filteredStates.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell!
        
        if tableView == self {
            
            cell = dequeueReusableCell(withIdentifier: "historySearchCell", for: indexPath)
        } else {
            
            cell = UITableViewCell()
            cell.textLabel?.text = filteredStates[indexPath.item]
        }
        
        return cell
    }
}

extension MyPlaceProfileHistoryTV: UISearchBarDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchString = self.searchController.searchBar.text!
        
        filteredStates = states.filter({ (state) -> Bool in
            
            return state.lowercased().contains(searchString.lowercased())
        })
        
        self.resultController.tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        profileVC?.changeViewDisplayed(0)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        profileVC?.changeViewDisplayed(128)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Search..!")
    }
}















