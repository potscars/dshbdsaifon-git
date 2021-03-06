//
//  WaterLevelMainTVC.swift
//  dashboardKB
//
//  Created by Mohd Zulhilmi Mohd Zain on 01/03/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class WaterLevelMainTVC: UITableViewController {
    
    let waterLevelNotification: Notification.Name = Notification.Name("waterLevelNotification")
    
    var listOfRivers: NSMutableArray? = []
    var selectedRiverDetails: NSDictionary = [:]
    var receivedListofRivers: NSMutableArray = []
    
    var receivedID: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupTableView()
        DBWebServices.getWaterLevelFeed(amount: 10, registeredNotification: waterLevelNotification.rawValue)
    }
    
    func setupTableView() {
        
        ZUISetup.setupTableView(tableView: self)
        tableView.estimatedRowHeight = 140.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.register(PlaceHolderCell.self, forCellReuseIdentifier: "PlaceholderCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(populateData(data:)), name: waterLevelNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: waterLevelNotification, object: nil);
    }

    @objc func populateData(data: NSNotification)
    {
        listOfRivers?.removeAllObjects()
        receivedListofRivers.removeAllObjects()
        
        let unWrapObject = data.value(forKey: "object") as! NSArray
        let dataReceives: NSArray = unWrapObject.value(forKey: "receives") as! NSArray
        
        print("[WaterLevelMainTVC] DataReceives returned is \(dataReceives)")
        
        var riverName: String = "N/A"
        var riverCurrentReportDate: String = "2222-12-31 00:00:00"
        var riverCurrentReportWaterLevel: String = "0.0"
        var riverWaterLevelDifference: String = "0.0"
        var riverPrevReportWaterLevel: String = "0.0"
        var riverCautionWaterLevel: String? = "0.0"
        var riverWarningWaterLevel: String? = "0.0"
        var riverDangerWaterLevel: String? = "0.0"
        
        for iARD in 0...unWrapObject.count - 1
        {
            //Caution, danger, depth, latitude, longitude
            
            let readReceiveData: NSMutableArray = (unWrapObject[iARD] as! NSDictionary).value(forKey: "receives") as! NSMutableArray
            let isSensorActive = (unWrapObject[iARD] as! NSDictionary).value(forKey: "is_active") as! String
            
            riverName = (unWrapObject[iARD] as! NSDictionary).value(forKey: "location") as! String
            riverCurrentReportDate = (readReceiveData[0] as! NSDictionary).value(forKey: "date_receive") as! String
            
            if let currentWaterLevel = (readReceiveData[0] as! NSDictionary).value(forKey: "water_depth") as? String {
                riverCurrentReportWaterLevel = currentWaterLevel
            }
            
            riverWaterLevelDifference = (readReceiveData[0] as! NSDictionary).value(forKey: "interval_different") as! String
            
            if let previousWaterLevel = (readReceiveData[0] as! NSDictionary).value(forKey: "interval_depth") as? String {
                riverPrevReportWaterLevel = previousWaterLevel
            }
            
            riverCautionWaterLevel = ((readReceiveData[0] as! NSDictionary).value(forKey: "location") as! NSDictionary).value(forKey: "caution") as? String
            riverWarningWaterLevel = ((readReceiveData[0] as! NSDictionary).value(forKey: "location") as! NSDictionary).value(forKey: "warning") as? String
            riverDangerWaterLevel = ((readReceiveData[0] as! NSDictionary).value(forKey: "location") as! NSDictionary).value(forKey: "danger") as? String
            
            let riverInfo: NSDictionary = ["RIVER_STATUS":DBWaterLevel.waterLevelStatus(currentLevel: String(riverCurrentReportWaterLevel), caution: riverCautionWaterLevel!, warning: riverWarningWaterLevel!, danger: riverDangerWaterLevel!),
                                           "RIVER_NAME":riverName,
                                           "RIVER_REPORT_DATE":ZDateTime.dateFormatConverter(valueInString: riverCurrentReportDate, dateTimeFormatFrom: nil, dateTimeFormatTo: ZDateTime.DateInLong),
                                           "RIVER_CURR_LEVEL":"\(riverCurrentReportWaterLevel)m",
                                           "RIVER_LEVEL_DIFF":"(\(riverWaterLevelDifference) m)",
                                           "RIVER_PREV_LEVEL":"\(riverPrevReportWaterLevel)m",
                "IS_ACTIVE": "\(isSensorActive)"]
            
            listOfRivers!.add(riverInfo)
            receivedListofRivers.add(readReceiveData)
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        NotificationCenter.default.removeObserver(self, name: waterLevelNotification, object: nil);
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(listOfRivers!.count == 0) { return 1 } else { return listOfRivers!.count }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //RiverLoadingCellID
        
        if(listOfRivers!.count == 0) {
            
            let cell: WaterLevelIntegratedTVCell = tableView.dequeueReusableCell(withIdentifier: "RiverLoadingCellID") as! WaterLevelIntegratedTVCell
            
            tableView.separatorStyle = UITableViewCellSeparatorStyle.none
            
            // Configure the cell...
            
            return cell
            
        }
        else {
            
            

            // Configure the cell...
            let tempData = listOfRivers?.object(at: indexPath.row) as! NSDictionary
            
            if (tempData["IS_ACTIVE"] as! String ) == "1" {
                let cell: WaterLevelIntegratedTVCell = tableView.dequeueReusableCell(withIdentifier: "RiverDetailedCellID") as! WaterLevelIntegratedTVCell
                
                cell.updateRiverLevelCell(data: listOfRivers?.object(at: indexPath.row) as!
                    NSDictionary)
                tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
                
                return cell
            } else {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceholderCell", for: indexPath) as! PlaceHolderCell
                
                cell.updateUI(withName: tempData["RIVER_NAME"] as! String)
                
                return cell
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let tempData = listOfRivers?.object(at: indexPath.row) as! NSDictionary
        
        if (tempData["IS_ACTIVE"] as! String ) == "1" {
        
            let receivedIdArray: NSArray = receivedListofRivers.value(forKey: "location_id") as! NSArray
            let getID: String = (receivedIdArray[indexPath.row] as! NSArray).object(at: 0) as! String
            
            receivedID = getID
            
            print("[WaterLevelMainTVC] Received ID is \(receivedID), with details of river is \(listOfRivers?.object(at: indexPath.row) as! NSDictionary)")
            
            selectedRiverDetails = listOfRivers?.object(at: indexPath.row) as! NSDictionary
            
            self.performSegue(withIdentifier: "DB_GOTO_RIVER_DETAILS", sender: self)
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(listOfRivers!.count == 0) {
            return 100
            
        } else {
            
            let tempData = listOfRivers?.object(at: indexPath.row) as! NSDictionary
            
            if (tempData["IS_ACTIVE"] as! String ) == "1" {
                return UITableViewAutomaticDimension
            } else {
                return 140.0
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        guard let descController: WaterLevelDetailsTVC = segue.destination as? WaterLevelDetailsTVC else { return }
        
        descController.selectedRiverDetails.add(selectedRiverDetails)
        descController.selectedRiverDetails.add(receivedListofRivers)
        descController.selectedRiverDetails.add(receivedID)
    }
}




