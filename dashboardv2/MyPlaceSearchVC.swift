//
//  MyPlaceSearchVC.swift
//  dashboardKB
//
//  Created by Mohd Zulhilmi Mohd Zain on 19/04/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MyPlaceSearchVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var uisbMPSVCSearchBar: UISearchBar!
    @IBOutlet weak var uilMPSVCSearchText: UILabel!
    
    var searchHistoryList: NSMutableArray = []
    var shouldShowResultsSearch: Bool = false
    var searchController: UISearchController!
    var resultController = UITableViewController()
    
    var states: [String]!
    var filteredResults: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let blankHeight = self.tabBarController?.tabBar.frame.height
        print("tabbar height \(blankHeight!)")
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.automaticallyAdjustsScrollViewInsets = true;
        
        //MARK: - Setting datasource and delegates for result tableview
        self.resultController.tableView.dataSource = self
        self.resultController.tableView.delegate = self
     
        states = ["San Francisco","New York","San Jose","Chicago","Los Angeles","Austin","Seattle"]
        searchHistoryList = ["Starbucks Coffee","Zawara Coffee Cyberjaya","Puffy Buffy Cyberjaya"]
        
        self.configureNavBar()
        self.configuringSearchBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let homeImage = UIImage(named: "ic_home_white")
        let homeButton = UIBarButtonItem(image: homeImage, style: .done, target: self, action: #selector(dismissMyPlace))
        
        self.navigationItem.rightBarButtonItem = homeButton
    }
    
    @objc func dismissMyPlace() {
        
        dismiss(animated: true, completion: nil)
    }
    
    func configuringSearchBar() {
        
        self.searchController = UISearchController(searchResultsController: resultController)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        
        let searchBar = searchController.searchBar
        
        searchBar.barTintColor = DBColorSet.myPlacePrimaryColor
        searchBar.tintColor = .white
        searchBar.isTranslucent = false
        searchBar.barStyle = .default
        //searchBar.backgroundImage = UIImage()
        searchBar.placeholder = "Search here..."
        searchBar.delegate = self
        searchBar.sizeToFit()
        
        self.tableView.tableHeaderView = searchBar
    }
    
    func configureNavBar() {
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = DBColorSet.myPlacePrimaryColor
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        title = "Search"
    }
}


extension MyPlaceSearchVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.tableView {
            
            return states.count
        } else {
            
            return filteredResults.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell!
        
        if tableView == self.tableView {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)
            cell.textLabel?.text = states[indexPath.item]
        } else {
            cell = UITableViewCell()
            cell.textLabel?.text = filteredResults[indexPath.item]
        }

        return cell
    }
}

extension MyPlaceSearchVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == resultController.tableView {
            
            print("ResultController pressed..!")
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let searchResultVC = storyboard.instantiateViewController(withIdentifier: "myPlaceSearchResultVC") as! MyPlaceSearchResultVC
            
            self.navigationController?.pushViewController(searchResultVC, animated: true)
        }
    }
}

extension MyPlaceSearchVC: UISearchBarDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchString = searchController.searchBar.text
        
        filteredResults = self.states.filter({ (state) -> Bool in
            
            return state.lowercased().contains((searchString?.lowercased())!)
        })
        
        self.resultController.tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        //searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        /*searchBar.text = nil
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.endEditing(true)*/
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if !shouldShowResultsSearch {
            shouldShowResultsSearch = true
        }
        
        if searchBar.text != nil {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let searchResultVC = storyboard.instantiateViewController(withIdentifier: "myPlaceSearchResultVC") as! MyPlaceSearchResultVC
            
            self.navigationController?.pushViewController(searchResultVC, animated: true)
        }
        
        searchBar.resignFirstResponder()
    }
}














