//
//  MyPlaceSearchResultVC.swift
//  dashboardKB
//
//  Created by Hainizam on 13/06/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MyPlaceSearchResultVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureTableView()
        self.configureNavBar()
    }
    
    func configureTableView() {
        
        self.tableView.dataSource = self
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 200.0
    }
    
    func configureNavBar() {
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
    }
}

extension MyPlaceSearchResultVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell", for: indexPath)
        
        return cell
    }
}





























