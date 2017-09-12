//
//  MySkoolMainTVC.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 23/01/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MySkoolMainTVC: UITableViewController {
    
    let registeredNotification: String = "MySkoolDataNotification"
    let tokenForMySkool: String = UserDefaults.standard.object(forKey: "SuccessLoggerMySkoolToken") as! String
    
    let dataArrays: NSMutableArray = []
    var detailsToSend: NSDictionary = [:]
    var dataLimiter: Int = 10
    var paging: Int = 1
    var canReloadMore: Bool = false
    var requiresMoreData: Bool = false
    
    var isFirstLoad: Bool = true
    var isRefreshing = false
    
    var cell: MySkoolIntegratedTVCell? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup untuk pull to refresh
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshed), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            
            tableView.refreshControl = refreshControl
        } else {
         
            tableView.addSubview(refreshControl!)
        }
        
        ZGraphics.applyNavigationBarColor(controller: self, setBarTintColor: DBColorSet.dashboardKBTertiaryColor, setBackButtonFontColor: UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0), setBarFontColor: UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0), setBarFontFace: UIFont.init(name: "Arial-BoldMT", size: CGFloat(17.0))!)
        
        ZUISetup.setupTableView(tableView: self)
        
        self.loadDataToView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(populateData(data:)), name: Notification.Name(registeredNotification), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: Notification.Name(registeredNotification), object: nil);
    }
    
    func refreshed(_ sender: UIRefreshControl) {
        
        self.isRefreshing = true
        self.loadDataToView()
    }
    
    func loadDataToView() {
        
        if(DBWebServices.checkConnectionToDashboard(viewController: self) == true) {
            
            self.resetData()
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
            
            DispatchQueue.global(qos: .userInitiated).async {
                
                DBWebServices.getMySkoolInboxFeed(tokenForMySkool: self.tokenForMySkool, page: 1, registeredNotification: self.registeredNotification)
            }
        }
    }
    
    func resetData()
    {
        self.dataLimiter = 10
        self.requiresMoreData = false
        self.canReloadMore = false
        self.paging = 1
        self.detailsToSend = [:]
    }
    
    func populateData(data: NSDictionary) {
    
        
        if isFirstLoad || isRefreshing {
            
            dataArrays.removeAllObjects()
        }
        
        let extractNotificationWrapper: NSDictionary = data.value(forKey: "object") as! NSDictionary
        let extractPaging: NSArray = extractNotificationWrapper.value(forKey: "paging") as! NSArray
        
        let pagingMaxFromAPIArray: NSArray = extractPaging.value(forKey: "pageCount") as! NSArray
        let pagingMaxFromAPI: Int = Int.init(String.init(describing: pagingMaxFromAPIArray.componentsJoined(by: "")))!
        
        let nextPageAllowedArray: NSArray = extractPaging.value(forKey: "nextPage") as! NSArray
        let nextPageAllowed: Int = Int.init(String.init(describing: nextPageAllowedArray.componentsJoined(by: "")))!
        
        let getData: NSArray = extractNotificationWrapper.value(forKey: "data") as! NSArray
        
        for i in 0...getData.count - 1 {
            
            let extractedData: NSDictionary = getData[i] as! NSDictionary
            
            dataArrays.add(["MESSAGE_SENDER":extractedData.value(forKey: "creator") as! String,
                            "MESSAGE_DATE":extractedData.value(forKey: "created") as! String,
                            "MESSAGE_TITLE":extractedData.value(forKey: "title") as! String,
                            "MESSAGE_SUMMARY":extractedData.value(forKey: "text") as! String,
                            "MESSAGE_DESC":extractedData.value(forKey: "content") as! String
                ])
        }
        
        print("[MySkoolMainTVC] \(dataArrays.count) per \(dataLimiter), paging \(paging) to \(pagingMaxFromAPI)")
        
        //if(paging == pagingMaxFromAPI) { self.canReloadMore = false } else { self.canReloadMore = true }
        
        if(nextPageAllowed == 0) { self.canReloadMore = false } else { self.canReloadMore = true }
        
        if (refreshControl?.isRefreshing)! {
            
            refreshControl?.endRefreshing()
            self.isRefreshing = false
        }
        
        DispatchQueue.main.async {
            
            //self.cell?.setLoadMoreState(isLoadingMore: false)
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
        
        if(self.isFirstLoad == true) { dataCount = 1 }
        
        print("[MySkoolMainTVC] Data count is \(dataCount)")
        
        return dataCount
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dataCount: Int = dataArrays.count
        
        if(self.isFirstLoad == true) {
   
            let cell: MySkoolIntegratedTVCell = tableView.dequeueReusableCell(withIdentifier: "MySkoolLoadingCellID") as! MySkoolIntegratedTVCell
            
            // Configure the cell...
            
            cell.setLoadingState(isLoading: true)
            
            self.isFirstLoad = false
            
            return cell
            
        }
        else {
            
            if(self.canReloadMore == true && indexPath.row == dataCount) {
                
                cell = tableView.dequeueReusableCell(withIdentifier: "MySkoolLoadMoreCellID") as? MySkoolIntegratedTVCell
                
                cell?.setLoadMoreState(isLoadingMore: false)
                
                // Configure the cell...
                
                return cell!
                
            }
            else {
                
                let cell: MySkoolIntegratedTVCell = tableView.dequeueReusableCell(withIdentifier: "MySkoolMainCellID") as! MySkoolIntegratedTVCell
                
                cell.updateFeedData(data: dataArrays.object(at: indexPath.row) as! NSDictionary)
                
                // Configure the cell...
                
                return cell
            }
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if(self.canReloadMore == true && indexPath.row == dataArrays.count && DBWebServices.checkConnectionToDashboard(viewController: self) == true) {
            
            self.tabBarController?.navigationItem.rightBarButtonItem?.isEnabled = false
            cell?.setLoadMoreState(isLoadingMore: true)
            
            self.paging += 1
            self.dataLimiter += 10

            DispatchQueue.global(qos: .userInitiated).async {
                
                DBWebServices.getMySkoolInboxFeed(tokenForMySkool:self.tokenForMySkool, page:self.paging, registeredNotification: self.registeredNotification)
            }
        }
        else if(DBWebServices.checkConnectionToDashboard(viewController: self) == true) {
            
            detailsToSend = dataArrays.object(at: indexPath.row) as! NSDictionary
            self.performSegue(withIdentifier: "DB_GOTO_MYSKOOL_DETAILS", sender: self)
            
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(self.canReloadMore == true && indexPath.row == dataArrays.count) {
            
            return 70.0
            
        }
        else {
            
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
  
        
        let descController: MySkoolDetailsTVC = segue.destination as! MySkoolDetailsTVC
        
        descController.detailsData = detailsToSend
    }
    

}
