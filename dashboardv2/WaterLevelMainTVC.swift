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
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        ZUISetup.setupTableView(tableView: self)
        
        DBWebServices.getWaterLevelFeed(amount: 10, registeredNotification: waterLevelNotification.rawValue)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(populateData(data:)), name: waterLevelNotification, object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        NotificationCenter.default.removeObserver(self, name: waterLevelNotification, object: nil);
        
    }

    @objc func populateData(data: NSNotification)
    {
        
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
                                           "RIVER_PREV_LEVEL":"\(riverPrevReportWaterLevel)m"]
            
            listOfRivers!.add(riverInfo)
            receivedListofRivers.add(readReceiveData)
        }
        
        DispatchQueue.main.async {
            
            self.tableView.reloadData()
            
        }
        
        
        NotificationCenter.default.removeObserver(self, name: waterLevelNotification, object: nil);
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
            
            let cell: WaterLevelIntegratedTVCell = tableView.dequeueReusableCell(withIdentifier: "RiverDetailedCellID") as! WaterLevelIntegratedTVCell

            // Configure the cell...
        
            cell.updateRiverLevelCell(data: listOfRivers?.object(at: indexPath.row) as! NSDictionary)
            
            tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
            

            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let receivedIdArray: NSArray = receivedListofRivers.value(forKey: "location_id") as! NSArray
        let getID: String = (receivedIdArray[indexPath.row] as! NSArray).object(at: 0) as! String
        
        receivedID = getID
        
        print("[WaterLevelMainTVC] Received ID is \(receivedID), with details of river is \(listOfRivers?.object(at: indexPath.row) as! NSDictionary)")
        
        selectedRiverDetails = listOfRivers?.object(at: indexPath.row) as! NSDictionary
        
        self.performSegue(withIdentifier: "DB_GOTO_RIVER_DETAILS", sender: self)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(listOfRivers!.count == 0) { return 100 } else { return 140 }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let descController: WaterLevelDetailsTVC = segue.destination as! WaterLevelDetailsTVC
        
        descController.selectedRiverDetails.add(selectedRiverDetails)
        descController.selectedRiverDetails.add(receivedListofRivers)
        descController.selectedRiverDetails.add(receivedID)
    }
    

}
