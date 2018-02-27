//
//  WaterLevelDetailsTVC.swift
//  dashboardKB
//
//  Created by Mohd Zulhilmi Mohd Zain on 02/03/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class WaterLevelDetailsTVC: UITableViewController {
    
    var selectedRiverDetails: NSMutableArray = []
    var waterDepthValues = [Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("[WLDTVC] Data acquired is \(selectedRiverDetails)")
        
        ZUISetup.setupTableView(tableView: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupGraphData()
        let indexPath = IndexPath(row: 1, section: 0)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func setupGraphData() {
        //check kalau id sama, simpan water depth untuk id tu.
        //kena loop dua kali, sebab data ada array inception.
        guard let id = selectedRiverDetails[2] as? String else { return }
        
        if let riverLists = selectedRiverDetails[1] as? NSArray {
            
            waterDepthValues.removeAll()
            for riverList in riverLists {
                guard let rivers = riverList as? NSArray else { return }
                
                for river in rivers {
                    if let locationID = (river as AnyObject).object(forKey: "location_id") as? String {
                        if locationID == id {
                            
                            guard let waterDepth = (river as AnyObject).object(forKey: "water_depth") as? String else { return }
                            let waterDepthInDouble = Double(waterDepth)
                            waterDepthValues.append(waterDepthInDouble!.rounded(toPlaces: 2))
                        }
                    }
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == 0) {
            let cell: WaterLevelIntegratedTVCell = tableView.dequeueReusableCell(withIdentifier: "RiverDetailedCellID") as! WaterLevelIntegratedTVCell
        
            // Configure the cell...
        
            cell.updateRiverLevelCell(data: selectedRiverDetails[0] as! NSDictionary)

            return cell
        }
        else {
            
            let graphCell = tableView.dequeueReusableCell(withIdentifier: "riverGraphCellIdentifier", for: indexPath) as! RiverLevelGraphCell
            graphCell.updateGraphUI(waterDepthValues: waterDepthValues)
            
            return graphCell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(indexPath.row == 0){
            return 139
        } else {
            return 300
        }
    }
}














