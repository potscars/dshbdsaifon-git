//
//  MyKomunitiMainAdminTVC.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 05/01/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MyKomunitiMainAdminTVC: UITableViewController {
    
    let dataArrays: NSMutableArray = []
    var detailsToSend: NSDictionary = [:]
    
    var dataLimiter: Int = 10
    var perPage = 10
    
    var isFirstLoad: Bool = true
    var isRefreshing: Bool = true
    
    var requiresMoreData: Bool = false
    var canReloadMore: Bool = false
    
    let notificationNameString: String = "MyKomunitiAdminData"
    
    var reloadCell: MyKomunitiLoadMoreDataTVCell? = nil
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ****** WARNING: IMPLEMENTATION OF LOADMORE, AND INTERNET CONNECTION IS PENDING ****** //

        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshed(_:)), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            
            tableView.refreshControl = refreshControl
        } else {
            
            tableView.addSubview(refreshControl!)
        }
        
        ZUISetup.setupTableViewWithTabView(tableView: self)
        
        self.loadDataToView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.populateData(data:)), name: Notification.Name(self.notificationNameString), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: Notification.Name(notificationNameString), object: nil);
        
    }
    
    @objc func refreshed(_ sender: UIRefreshControl) {
        
        self.isRefreshing = true
        self.loadDataToView()
    }
    
    func loadDataToView() {
        
        if(DBWebServices.checkConnectionToDashboard(viewController: self) == true) {
            
            self.resetData()
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
            
            DispatchQueue.global(qos: .userInitiated).async {
                
                DBWebServices.getMyKomunitiAdminFeed(page: self.perPage, registeredNotification: self.notificationNameString)
            }
        }
    }
    
    func resetData()
    {
        self.dataLimiter = 10
        self.requiresMoreData = false
        self.canReloadMore = false
        self.perPage = 10
        self.detailsToSend = [:]
    }

    @objc func populateData(data: NSDictionary) {
        
        if self.isFirstLoad || self.isRefreshing {
            dataArrays.removeAllObjects()
        }
        else {
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        }
        
        let extractNotificationWrapper: NSDictionary = data.value(forKey: "object") as! NSDictionary
        
        let totalMaxFromAPI: Int = extractNotificationWrapper.value(forKey: "total") as! Int
        let getData: NSArray = extractNotificationWrapper.value(forKey: "data") as! NSArray
        
        for i in 0...getData.count - 1 {
            
            let extractedData: NSDictionary = getData[i] as! NSDictionary
            let getUserData: NSDictionary = extractedData.value(forKey: "user") as! NSDictionary
            
            dataArrays.add(["MESSAGE_LEVEL":"PENTADBIR",
                            "MESSAGE_SENDER":"\(getUserData.value(forKey:"first_name") as! String) \(getUserData.value(forKey:"last_name") as! String)",
                            "MESSAGE_DATE":getUserData.value(forKey: "updated_at") as! String,
                            "MESSAGE_TITLE":extractedData.value(forKey: "title") as! String,
                            "MESSAGE_SUMMARY":extractedData.value(forKey: "content") as! String,
                            "MESSAGE_DESC":extractedData.value(forKey: "content") as! String
                ])
            
        }
        
        print("[MyKomunitiMainTVC] \(dataArrays.count) per \(dataLimiter), maximum to \(totalMaxFromAPI)")
        
        if(totalMaxFromAPI <= dataLimiter) { self.canReloadMore = false } else { self.canReloadMore = true }
        
        if (refreshControl?.isRefreshing)! {
            
            self.isRefreshing = false
            refreshControl?.endRefreshing()
        }
        
        DispatchQueue.main.async {
            
            self.reloadCell?.setFinishState()
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
            self.tableView.reloadData()
            
        }
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
        
        var dataCount: Int = dataArrays.count
        
        if(self.canReloadMore == true) { dataCount += 1 }
        
        if(self.isFirstLoad == true) { dataCount = 1  }
        
        print("Data Count \(dataCount)")
        
        return dataCount
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dataCount: Int = dataArrays.count
        
        if(self.isFirstLoad == true)
        {
            let cell: MyKomunitiLoadingTVCell = tableView.dequeueReusableCell(withIdentifier: "MKAdminLoadingCellID") as! MyKomunitiLoadingTVCell
            
            // Configure the cell...
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none
             tableView.allowsSelection = false
            
            self.isFirstLoad = false
            
            return cell
        }
        else
        {
            if(self.canReloadMore == true && indexPath.row == dataCount)
            {
                print("[MyKomunitiMainTVC] Calling loadmore cell")
                //MKPublicLoadMoreCellID
                reloadCell = tableView.dequeueReusableCell(withIdentifier: "MKAdminLoadMoreCellID") as? MyKomunitiLoadMoreDataTVCell
                
                return reloadCell!
            }
            else
            {
                let cell: MyKomunitiMainTVCell = tableView.dequeueReusableCell(withIdentifier: "MyKomunitiMainCellID") as! MyKomunitiMainTVCell
                
                    // Configure the cell...
            
                cell.selectionStyle = UITableViewCellSelectionStyle.default
                tableView.allowsSelection = true
                cell.updateCell(data: dataArrays.object(at: indexPath.row) as! NSDictionary)
                
                return cell
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if(self.canReloadMore == true && indexPath.row == dataArrays.count && DBWebServices.checkConnectionToDashboard(viewController: self) == true) {
            
            self.tabBarController?.navigationItem.rightBarButtonItem?.isEnabled = false
            reloadCell?.setProcessingState()
            
            self.perPage += 1
            self.dataLimiter += 10
            
            DispatchQueue.global(qos: .userInitiated).async {
                
                DBWebServices.getMyKomunitiAdminFeed(page: self.perPage, registeredNotification: self.notificationNameString)
            }
        }
        else if(DBWebServices.checkConnectionToDashboard(viewController: self) == true) {
        
            detailsToSend = dataArrays.object(at: indexPath.row) as! NSDictionary
        
            self.performSegue(withIdentifier: "DB_GOTO_MYKOMUNITI_DETAILS", sender: self)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(self.canReloadMore == true && indexPath.row == dataArrays.count)
        {
            return 70.0
        }
        else
        {
            return 100.0
        }
        
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
        
        let descController: MyKomunitiDetailsTVC = segue.destination as! MyKomunitiDetailsTVC
        
        descController.detailsData = detailsToSend
    }
    

}
