//
//  MyShopLatestProdTVC.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 02/02/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MyShopLatestProdTVC: UITableViewController {
    
    let registeredNotification: String = "MyShopLatestProductData"
    
    var requestProduct: String = ""
    
    let dataArrays: NSMutableArray = []
    var detailsToSend: NSDictionary = [:]
    var cachedImage: NSMutableArray = []
    
    var paging = 1
    var loading: Bool = true
    var canReloadMore: Bool = false
    
    var reloadCell: MyShopIntegratedTVCell? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        ZUISetup.setupTableViewWithTabView(tableView: self)
        
        if(DBWebServices.checkConnectionToDashboard(viewController: self) == true) {
            
            requestingURL(page: 1)
            
        }
    }
    
    func requestingURL(page: Int?)
    {
        if(requestProduct == "LATEST_PROD")
        {
            DBWebServices.getMyShopLatestProdFeed(page: page!, registeredNotification: registeredNotification)
            self.navigationItem.title = "Terkini"
        }
        else if(requestProduct == "POPULAR_PROD")
        {
            DBWebServices.getMyShopPopularProdFeed(page: page!, registeredNotification: registeredNotification)
            self.navigationItem.title = "Popular"
        }
        else if(requestProduct == "HI_RATING_PROD")
        {
            DBWebServices.getMyShopHiRatingProdFeed(page: page!, registeredNotification: registeredNotification)
            self.navigationItem.title = "Penilaian Tertinggi"
        }
        else if(requestProduct == "LOCAL_PROD")
        {
            DBWebServices.getMyShopLocalProdFeed(registeredNotification: registeredNotification)
            self.navigationItem.title = "Tempatan"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let refreshButton: UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.refresh, target: self, action: #selector(setRefresh(sender:)))
        self.navigationItem.rightBarButtonItem = refreshButton
        
        NotificationCenter.default.addObserver(self, selector: #selector(populateData(data:)), name: Notification.Name(registeredNotification), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: Notification.Name(registeredNotification), object: nil);
        
    }
    
    func resetData() {
        
        self.loading = true
        self.canReloadMore = false
        self.paging = 1
        self.detailsToSend = [:]
        self.dataArrays.removeAllObjects()
        self.tableView.reloadData()
    }
    
    func setRefresh(sender: UIBarButtonItem) {
        
        if(DBWebServices.checkConnectionToDashboard(viewController: self) == true) {
            
            self.resetData()
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
            requestingURL(page: 1)
        }
    }
    
    func reloadPresets(inLoadingState: Bool)
    {
        if(inLoadingState == false) {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
        else{
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }
        
    }
    
    func populateData(data: NSDictionary) {
    
        self.reloadPresets(inLoadingState: true)
        
        let extractNotificationWrapper: NSDictionary = data.value(forKey: "object") as! NSDictionary
        
        let pagingMaxFromAPI: Int = extractNotificationWrapper.value(forKey: "last_page") as! Int
        
        let unwrapData: NSArray = extractNotificationWrapper.value(forKey: "data") as! NSArray
        
        for i in 0...unwrapData.count - 1 {
            
            let extractedData: NSDictionary = unwrapData[i] as! NSDictionary
            
            //cachedImage.add(ZImages.getImageFromUrlSession(fromURL: extractedData.value(forKey: "url_photo_thumb") as! String, defaultImage: "ic_nopic"))
            
            let dataReceived: [String:Any] = ["MYSHOP_PROD_ID":nullCheckerReturnToString(string: extractedData.value(forKey: "id") as? String),
                "MYSHOP_PROD_TITLE":nullCheckerReturnToString(string: extractedData.value(forKey: "title") as? String),
                "MYSHOP_PROD_DESCRIPTION":nullCheckerReturnToString(string:extractedData.value(forKey: "description") as? String),
                "MYSHOP_PROD_RATING_COUNT":nullCheckerReturnToString(string:extractedData.value(forKey: "rating_count") as? String),
                "MYSHOP_PROD_VIEWER_COUNT":nullCheckerReturnToString(string:extractedData.value(forKey: "viewer_count") as? String),
                "MYSHOP_PROD_VIEWER_COUNT_WEEKLY":nullCheckerReturnToString(string:extractedData.value(forKey: "viewer_count_by_week") as? String),
                "MYSHOP_PROD_SEARCH_COUNT_WEEKLY":nullCheckerReturnToString(string:extractedData.value(forKey: "search_count_by_week") as? String),
                "MYSHOP_PROD_WEEK_VIEWER":nullCheckerReturnToString(string:extractedData.value(forKey: "week_viewer") as? String),
                "MYSHOP_PROD_COMMENT_COUNT":nullCheckerReturnToString(string:extractedData.value(forKey: "comment_count") as? String),
                "MYSHOP_PROD_PRICE":nullCheckerReturnToString(string:extractedData.value(forKey: "price") as? String),
                "MYSHOP_PROD_QUANTITY":nullCheckerReturnToString(string:extractedData.value(forKey: "quantity") as? String),
                "MYSHOP_PROD_SKU":nullCheckerReturnToString(string:extractedData.value(forKey: "sku") as? String),
                "MYSHOP_PROD_PER_ITEM_SHIPPING_ID":nullCheckerReturnToString(string:extractedData.value(forKey: "per_item_shipping_id") as? String),
                "MYSHOP_PROD_OPTION":nullCheckerReturnToString(string:extractedData.value(forKey: "option") as? String),
                "MYSHOP_PROD_DATE":nullCheckerReturnToString(string:extractedData.value(forKey: "date") as? String),
                "MYSHOP_PROD_TERM":nullCheckerReturnToString(string:extractedData.value(forKey: "term") as? String),
                "MYSHOP_PROD_UPDATE_DATE":nullCheckerReturnToString(string:extractedData.value(forKey: "updated_at") as? String),
                "MYSHOP_PROD_CREATED_DATE":nullCheckerReturnToString(string:extractedData.value(forKey: "created_at") as? String),
                "MYSHOP_PROD_PHOTO_THUMB":nullCheckerReturnToString(string:extractedData.value(forKey: "url_photo_thumb") as? String),
                "MYSHOP_PROD_PHOTO_LARGE":nullCheckerReturnToString(string:extractedData.value(forKey: "url_photo_large") as? String),
                "MYSHOP_PROD_PHOTO_ARRAYS":extractedData.value(forKey: "photos") as? NSArray ?? []
            ]
            
            dataArrays.add(dataReceived)
            
        }
        
         print("[MyShopLatestProdTVC] \(paging) to \(pagingMaxFromAPI)")
        
        if(paging == pagingMaxFromAPI) { self.canReloadMore = false } else { self.canReloadMore = true }
        
        DispatchQueue.main.async {
            
            self.loading = false
            self.reloadCell?.updateReloadCell(isLoading: false, forCellID: "MyShopLoadMoreCellID")
            self.reloadPresets(inLoadingState: false)
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
            self.tableView.reloadData()
        }
        
    }
    
    func nullCheckerReturnToString(string: String?) -> String {
        
        var stringCheck = ""
        
        if(string == nil) {
            
            stringCheck = "N/A"
            
        }
        else {
            
            stringCheck = string!
            
        }
        
        return stringCheck
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
        
        if(self.loading == true) { dataCount = 1 }
        
        return dataCount
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dataCount: Int = dataArrays.count
        
        if(self.loading == true)
        {
            self.tabBarController?.navigationItem.rightBarButtonItem?.isEnabled = false
            
            let cell: MyShopIntegratedTVCell = tableView.dequeueReusableCell(withIdentifier: "MyShopLatestLoadingCellID") as! MyShopIntegratedTVCell
            
            // Configure the cell...
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            tableView.allowsSelection = false
            
            return cell
        }
        else {
            
            if(self.canReloadMore == true && indexPath.row == dataCount)
            {
                print("[MyShopLatestProdTVC] Calling loadmore cell")
                //MKPublicLoadMoreCellID
                reloadCell = tableView.dequeueReusableCell(withIdentifier: "MyShopLoadMoreCellID") as? MyShopIntegratedTVCell
                reloadCell?.backgroundColor = DBColorSet.myShopColor
                reloadCell?.uilMSITVCLoadMoreLabel.textColor = UIColor.white
                
                reloadCell?.selectionStyle = UITableViewCellSelectionStyle.default
                tableView.allowsSelection = true
                
                return reloadCell!
            }
            else
            {
                let cell: MyShopIntegratedTVCell = tableView.dequeueReusableCell(withIdentifier: "MyShopProductListingCellID") as! MyShopIntegratedTVCell

                // Configure the cell...
                cell.tag = indexPath.row
                cell.setUpdateProductListing(data: dataArrays.object(at: indexPath.row) as! NSDictionary)
                cell.selectionStyle = UITableViewCellSelectionStyle.default
                tableView.allowsSelection = true

                return cell
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if(self.canReloadMore == true && indexPath.row == dataArrays.count && DBWebServices.checkConnectionToDashboard(viewController: self) == true) {
            
            self.reloadCell?.updateReloadCell(isLoading: true, forCellID: "MyShopLoadMoreCellID")
            self.paging += 1
            
            requestingURL(page: paging)
            
        }
        else if(DBWebServices.checkConnectionToDashboard(viewController: self) == true) {
            
            detailsToSend = dataArrays.object(at: indexPath.row) as! NSDictionary
            self.performSegue(withIdentifier: "DB_MYSHOP_GOTO_DETAILS", sender: self)
            
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(self.canReloadMore == true && indexPath.row == dataArrays.count)
        {
            return 60.0
        }
        else if(self.loading == true)
        {
            return 100.0
        }
        else
        {
            return 130.0
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
        
        let descController: MyShopProductDetailsTVC = segue.destination as! MyShopProductDetailsTVC
        
        descController.detailsData = detailsToSend
    }
    

}
