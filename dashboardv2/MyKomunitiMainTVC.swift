//
//  MyKomunitiMainTVC.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 04/01/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MyKomunitiMainTVC: UITableViewController {
    
    let dataArrays: NSMutableArray = []
    var detailsToSend: NSDictionary = [:]
    
    //Cap untuk bape data boleh load
    var dataLimiter: Int = 10
    var paging = 1
    
    //Loading untuk first load
    var isFirstLoad: Bool = true
    var isRefreshing: Bool = false
    var requiresMoreData: Bool = false
    
    //Kalau data dari api ada lagi mende ni true.
    var canReloadMore: Bool = false
    
    let registeredNotification: String = "MyKomunitiPublicData"
    let errorNotificationName: String = "ErrorNotificationName"
    
    var reloadCell: MyKomunitiLoadMoreDataTVCell? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //Setup untuk pull to refresh, hold kejap.
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshed(_:)), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            
            tableView.refreshControl = refreshControl
        } else {
            
            tableView.addSubview(refreshControl!)
        }
        
        ZUISetup.setupTableViewWithTabView(tableView: self)
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 70.0
    
        self.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(populateData(data:)), name: Notification.Name(registeredNotification), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(errorNotification(errorMessage:)), name: Notification.Name(errorNotificationName), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        DispatchQueue.main.async {
            
            NotificationCenter.default.removeObserver(self, name: Notification.Name(self.registeredNotification), object: nil);
            
            NotificationCenter.default.removeObserver(self, name: Notification.Name(self.errorNotificationName), object: nil);
        }
    }
    
    func refreshed(_ sender: UIRefreshControl) {
        
        self.isRefreshing = true
        self.loadData()
    }
    
    //Load data to foreground
    func loadData() {
        
        if(DBWebServices.checkConnectionToDashboard(viewController: self) == true) {
            
            self.resetData()
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
            
            DispatchQueue.global(qos: .userInitiated).async {
                
                DBWebServices.getMyKomunitiPublicFeed(self, page: self.paging, registeredNotification: self.registeredNotification)
            }
        }
    }
    
    func errorNotification(errorMessage: String) {
        
        print("Error Detected!")
    }
    
    func resetData()
    {
        self.dataLimiter = 10
        self.requiresMoreData = false
        self.canReloadMore = false
        self.paging = 1
        self.detailsToSend = [:]
    }
    
    @objc func populateData(data: NSDictionary)
    {
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        //Kalau first load or baru refresh, clear dulu dataArrays.
        if self.isFirstLoad || self.isRefreshing {
            dataArrays.removeAllObjects()
        }
            
        else { self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none }
        
        let extractNotificationWrapper: NSDictionary = data.value(forKey: "object") as! NSDictionary
        
        //print(extractNotificationWrapper)
        
        let pagingMaxFromAPI: Int = extractNotificationWrapper.value(forKey: "last_page") as! Int
        let getData: NSArray = extractNotificationWrapper.value(forKey: "data") as! NSArray
        
        for i in 0...getData.count - 1 {
            
            let extractedData: NSDictionary = getData[i] as! NSDictionary
            let getUserData: NSDictionary = extractedData.value(forKey: "user") as! NSDictionary
            
            dataArrays.add(["MESSAGE_LEVEL":"AWAM",
                            "MESSAGE_SENDER":getUserData.value(forKey: "full_name") as! String,
                            "MESSAGE_DATE":getUserData.value(forKey: "updated_at") as! String,
                            "MESSAGE_TITLE":extractedData.value(forKey: "title") as! String,
                            "MESSAGE_SUMMARY":extractedData.value(forKey: "excerpt") as! String,
                            "MESSAGE_DESC":extractedData.value(forKey: "content") as! String,
                            "MESSAGE_IMAGES":extractedData.value(forKey: "images") as? NSArray ?? []
                ])
        }
        
        print("[MyKomunitiMainTVC] \(dataArrays.count) per \(dataLimiter), maximum to \(pagingMaxFromAPI)")
        
        if(paging == pagingMaxFromAPI) {
            
            self.canReloadMore = false
        } else {
            
            self.canReloadMore = true
        }
        
        if (refreshControl?.isRefreshing)! {
            
            refreshControl?.endRefreshing()
            self.isRefreshing = false
        }
        
        DispatchQueue.main.async {
            
            self.reloadCell?.setFinishState()
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
            self.tableView.reloadData()
        }
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
        
        print("[MyKomunitiMainTVC] Data count is \(dataCount)")
        
        return dataCount
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Configure the cell...
        
        let dataCount: Int = dataArrays.count
        //if(self.canReloadMore == true) { dataCount += 1 }
        
        if(self.isFirstLoad == true)
        {
            self.tabBarController?.navigationItem.rightBarButtonItem?.isEnabled = false
            
            let cell: MyKomunitiLoadingTVCell = tableView.dequeueReusableCell(withIdentifier: "MKPublicLoadingCellID") as! MyKomunitiLoadingTVCell
            
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
                reloadCell = tableView.dequeueReusableCell(withIdentifier: "MKPublicLoadMoreCellID") as? MyKomunitiLoadMoreDataTVCell
                
                return reloadCell!
            }
            else {
                
                let dataInDict: NSDictionary = dataArrays.object(at: indexPath.row) as! NSDictionary
                let imageArray: NSArray = dataInDict.value(forKey: "MESSAGE_IMAGES") as! NSArray
                
                if(imageArray.count != 0) {
                    print("imagedata avail")
                    ////MyKomunitiMainPicCellID
                    let cell: MyKomunitiMainTVCell = tableView.dequeueReusableCell(withIdentifier: "MyKomunitiMainPicCellID") as! MyKomunitiMainTVCell
                    
                    cell.selectionStyle = UITableViewCellSelectionStyle.default
                    tableView.allowsSelection = true
                    cell.updateCell(data: dataInDict)
                    cell.includePic(data: dataInDict)
                    
                    return cell
                }
                else {
                    let cell: MyKomunitiMainTVCell = tableView.dequeueReusableCell(withIdentifier: "MyKomunitiMainCellID") as! MyKomunitiMainTVCell
                    
                    cell.selectionStyle = UITableViewCellSelectionStyle.default
                    tableView.allowsSelection = true
                    cell.updateCell(data: dataInDict)
                    
                    return cell
                }
                
                
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if(self.canReloadMore == true && indexPath.row == dataArrays.count && DBWebServices.checkConnectionToDashboard(viewController: self) == true) {
            
            reloadCell?.setProcessingState()
            
            self.paging += 1
            self.dataLimiter += 10
            
            DispatchQueue.global(qos: .userInitiated).async {
                
                DBWebServices.getMyKomunitiPublicFeed(self, page: self.paging, registeredNotification: self.registeredNotification)
            }
        }
        else if(DBWebServices.checkConnectionToDashboard(viewController: self) == true) {
            
            detailsToSend = dataArrays.object(at: indexPath.row) as! NSDictionary
            self.performSegue(withIdentifier: "DB_GOTO_MYKOMUNITI_DETAILS", sender: self)
            
        }
    }
    /*
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //300
        if(self.canReloadMore == true && indexPath.row == dataArrays.count)
        {
            return 70.0
        }
        else
        {
            return 100.0
        }
        
    }
 */
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let descController: MyKomunitiDetailsTVC = segue.destination as! MyKomunitiDetailsTVC
        
        descController.detailsData = detailsToSend
        
        /*    ["MESSAGE_SENDER":"MIRA FILZAH",
             "MESSAGE_LEVEL":"AWAM",
             "MESSAGE_TITLE":"Super Mario Run Is Here Now!",
             "MESSAGE_DATE":"4 Januari 2017 pada 4:09:16 PTG",
             "MESSAGE_DESC":"Beginning in 1997, the character regularly appeared in comics by Top Cow Productions. Lara Croft first appeared in a crossover in Sara Pezzini's Witchblade, and later starred in her own comic book series in 1999.[31] The series began with Dan Jurgens as the writer, featuring artwork by Andy Park and Jon Sibal.[32] The stories were unrelated to the video games until issue 32 of the Tomb Raider series, which adapted Angel of Darkness's plot.[31] The series ran for 50 issues in addition to special issues.[33] Other printed adaptations are Lara Croft Tomb Raider: The Amulet of Power, a 2003 novel written by Mike Resnick; Lara Croft Tomb Raider: The Lost Cult, a 2004 novel written by E. E. Knight; and Lara Croft Tomb Raider: The Man of Bronze, a 2005 novel written by James Alan Gardner.[34][35][36]Beginning in 1997, the character regularly appeared in comics by Top Cow Productions. Lara Croft first appeared in a crossover in Sara Pezzini's Witchblade, and later starred in her own comic book series in 1999.[31] The series began with Dan Jurgens as the writer, featuring artwork by Andy Park and Jon Sibal.[32] The stories were unrelated to the video games until issue 32 of the Tomb Raider series, which adapted Angel of Darkness's plot.[31] The series ran for 50 issues in addition to special issues.[33] Other printed adaptations are Lara Croft Tomb Raider: The Amulet of Power, a 2003 novel written by Mike Resnick; Lara Croft Tomb Raider: The Lost Cult, a 2004 novel written by E. E. Knight; and Lara Croft Tomb Raider: The Man of Bronze, a 2005 novel written by James Alan Gardner.[34][35][36]  "]
        */
        
    }
    

}









