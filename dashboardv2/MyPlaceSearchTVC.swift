//
//  MyPlaceSearchTVC.swift
//  dashboardKB
//
//  Created by Mohd Zulhilmi Mohd Zain on 18/04/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MyPlaceSearchTVC: UITableViewController, UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {

    var searchHistoryList: NSMutableArray = []
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = true
        
        self.navigationItem.titleView = self.searchController.searchBar
        
        self.definesPresentationContext = true
        
        searchHistoryList = ["DUMMY_DATA","Starbucks Coffee","Zawara Coffee Cyberjaya","Puffy Buffy Cyberjaya"]
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchHistoryList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == 0) {
        
            let cell: MyPlaceSearchTVCell = tableView.dequeueReusableCell(withIdentifier: "MPSearchTitleCellID") as! MyPlaceSearchTVCell
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            return cell
            
        }
        else {
            
            let cell: MyPlaceSearchTVCell = tableView.dequeueReusableCell(withIdentifier: "MPSearchListCellID") as! MyPlaceSearchTVCell

            cell.selectionStyle = UITableViewCellSelectionStyle.default
            // Configure the cell...
            
            cell.updateSearchList(data: ["SEARCH_HISTORY_NAME":searchHistoryList.object(at: indexPath.row)])

            return cell
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(indexPath.row == 0) {
            return 80
        }
        else {
            return 41
        }
    }
}




















