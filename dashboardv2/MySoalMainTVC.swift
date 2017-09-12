//
//  MySoalMainTVC.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 18/01/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MySoalMainTVC: UITableViewController {
    
    let registeredNotification: String = "MySoalDataNotification"
    let tokenForMySoal: String = UserDefaults.standard.object(forKey: "SuccessLoggerMySoalToken") as! String
    
    let dataArrays: NSMutableArray = []
    var detailsToSend: NSDictionary = [:]
    var dataLimiter: Int = 10
    var paging: Int = 1
    var canReloadMore: Bool = false
    var requiresMoreData: Bool = false
    
    var isFirstLoad: Bool = true
    var isRefreshing = false
    
    var cell: MySoalIntegratedTVCell? = nil
    
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
                
                DBWebServices.getMySoalFeed(tokenForMySoal: self.tokenForMySoal, page: self.paging, registeredNotification: self.registeredNotification)
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
    
    func populateData(data: NSDictionary)
    {
        
        if isFirstLoad || isRefreshing {
            
            dataArrays.removeAllObjects()
        }
        
        let extractNotificationWrapper: NSDictionary = data.value(forKey: "object") as! NSDictionary
        let extractPaging: NSArray = extractNotificationWrapper.value(forKey: "paging") as! NSArray
        
        let pagingMaxFromAPIArray: NSArray = extractPaging.value(forKey: "pageCount") as! NSArray
        
        let pagingMaxFromAPI: Int = Int.init(String.init(describing: pagingMaxFromAPIArray.componentsJoined(by: "")))!
        
        let getData: NSArray = extractNotificationWrapper.value(forKey: "mail") as! NSArray
        
        for i in 0...getData.count - 1 {
            
            let extractedData: NSDictionary = getData[i] as! NSDictionary
            
            let dateStacked: String = "\(extractedData.value(forKey: "ori_date") as! String) \(extractedData.value(forKey: "ori_time") as! String)"
            let convertedDate: String = "\(ZDateTime.dateFormatConverter(valueInString: dateStacked, dateTimeFormatFrom: "dd/MM/yyyy h:mm a", dateTimeFormatTo: ZDateTime.DateInShort))"
            print("[MyKomunitiMainTVC] date: \(convertedDate)")
            
            
            dataArrays.add(["MESSAGE_SENDER":extractedData.value(forKey: "sender") as! String,
                            "MESSAGE_DATE":extractedData.value(forKey: "ori_date") as! String,
                            "MESSAGE_TIME":extractedData.value(forKey: "ori_time") as! String,
                            "MESSAGE_DATE_LONG": ZDateTime.dateFormatConverter(valueInString: dateStacked, dateTimeFormatFrom: "dd/MM/yyyy h:mm a", dateTimeFormatTo: ZDateTime.DateInLong),
                            "MESSAGE_DATE_SHORT": ZDateTime.dateFormatConverter(valueInString: dateStacked, dateTimeFormatFrom: "dd/MM/yyyy h:mm a", dateTimeFormatTo: ZDateTime.DateInShort),
                            "MESSAGE_TITLE":extractedData.value(forKey: "title") as! String,
                            "MESSAGE_SUMMARY":extractedData.value(forKey: "summary") as! String,
                            "MESSAGE_DESC":extractedData.value(forKey: "content") as! String
                ])
        }
        
        print("[MySoalMainTVC] \(dataArrays.count) per \(dataLimiter), paging \(paging) to \(pagingMaxFromAPI)")
        
        //if(paging == pagingMaxFromAPI) { self.canReloadMore = false } else { self.canReloadMore = true }
        
        if(paging >= pagingMaxFromAPI) { self.canReloadMore = false } else { self.canReloadMore = true }
        
        if (refreshControl?.isRefreshing)! {
            
            self.isRefreshing = false
            refreshControl?.endRefreshing()
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
        
        print("[MySoalMainTVC] Data count is \(dataCount)")
        
        return dataCount
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dataCount: Int = dataArrays.count
        
        if(self.isFirstLoad == true) {
            
            let cell: MySoalIntegratedTVCell = tableView.dequeueReusableCell(withIdentifier: "MySoalLoadingCellID") as! MySoalIntegratedTVCell
            
            // Configure the cell...
            
            cell.setLoadingState(isLoading: true)
            
            self.isFirstLoad = false
            
            return cell
            
        }
        else {
            
            if(self.canReloadMore == true && indexPath.row == dataCount) {
                
                cell = tableView.dequeueReusableCell(withIdentifier: "MySoalLoadMoreCellID") as? MySoalIntegratedTVCell
                
                cell?.setLoadMoreState(isLoadingMore: false)
                
                // Configure the cell...
                
                return cell!
                
            }
            else {
                
                let cell: MySoalIntegratedTVCell = tableView.dequeueReusableCell(withIdentifier: "MySoalMainCellID") as! MySoalIntegratedTVCell
                
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
                
                DBWebServices.getMySoalFeed(tokenForMySoal:self.tokenForMySoal, page:self.paging, registeredNotification: self.registeredNotification)
            }
        }
        else if(DBWebServices.checkConnectionToDashboard(viewController: self) == true) {
            
            detailsToSend = dataArrays.object(at: indexPath.row) as! NSDictionary
            self.performSegue(withIdentifier: "DB_GOTO_MYSOAL_DETAILS", sender: self)
            
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let descController: MySoalDetailsTVC = segue.destination as! MySoalDetailsTVC
        
        descController.detailsData = detailsToSend
        
    }
    

}
























