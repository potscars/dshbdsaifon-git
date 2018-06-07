//
//  SaifonAnnouncementTVC.swift
//  dashboardKB
//
//  Created by Mohd Zulhilmi Mohd Zain on 08/03/2018.
//  Copyright © 2018 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class SaifonAnnouncementTVC: UITableViewController {
    
    var dataProvided: NSArray? = []
    var arrayedData: NSMutableArray? = []
    var selectedData: NSDictionary? = [:]
    var status: Int = 0
    var finishLoad: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 110.0
        
        let np: NetworkProcessor = NetworkProcessor.init("http://saifon.my/api/feed")
        np.postRequestJSONFromUrl(["paginate":"10"], completion: { (response,error) in
            
            if response != nil {
                if(response!["status"] as! Int == 1) {
                    
                    print("[SaifonAnnouncement] Status OK.")
                    self.status = 1
                    self.finishLoad = 1
                    self.dataProvided = (response!["data"] as! NSDictionary).value(forKey: "data") as? NSArray ?? []
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                } else {
                    print("[SaifonAnnouncement] Fail to load data.")
                    self.status = 0
                    self.finishLoad = 1
                }
            }
            else {
                print("[SaifonAnnouncement] Fail to contact server.")
                self.status = 0
                self.finishLoad = 1
            }
            
            
            
        })
        
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
        if(status == 1) {
            return self.dataProvided?.count ?? 1
        }
        else {
            return 1
        }
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if(self.finishLoad != 0){
            //SaifonAnnounceLoadingCellID
            if(self.status != 0){
                if(self.dataProvided?.count != 0){
                    let cell: SaifonAnnouncementTVCell = tableView.dequeueReusableCell(withIdentifier: "SaifonAnnounceNoImgCellID", for: indexPath) as! SaifonAnnouncementTVCell
                    
                    // Configure the cell...
                    let articleAnnouncer: String = ((self.dataProvided?.object(at: indexPath.row) as? NSDictionary ?? ["user":"N/A"]).value(forKey: "user") as? NSDictionary ?? ["name":"N/A"]).value(forKey: "name") as? String ?? "N/A"
                    let articleDate: String = (self.dataProvided?.object(at: indexPath.row) as? NSDictionary ?? ["updated_at":"0000-00-00 00:00:00"]).value(forKey: "updated_at") as? String ?? "0000-00-00 00:00:00"
                    let articleDesc: String = (self.dataProvided?.object(at: indexPath.row) as? NSDictionary ?? ["content":"N/A"]).value(forKey: "content") as? String ?? "N/A"
                    
                    selectedData = ["ANNOUNCER":articleAnnouncer, "DATE":ZDateTime.dateFormatConverter(valueInString: articleDate, dateTimeFormatFrom: nil, dateTimeFormatTo: ZDateTime.DateInLong), "DESC":articleDesc]
                    arrayedData?.add(selectedData ?? [:])
                    
                    cell.updateCell(data: selectedData!)
                    
                    return cell
                }
                else {
                    //nodata
                    let cell: SaifonAnnouncementTVCell = tableView.dequeueReusableCell(withIdentifier: "SaifonAnnounceErrorCellID", for: indexPath) as! SaifonAnnouncementTVCell
                    
                    // Configure the cell...
                    // cell
                    
                    return cell
                }
            } else {
                //api returns error
                let cell: SaifonAnnouncementTVCell = tableView.dequeueReusableCell(withIdentifier: "SaifonAnnounceErrorCellID", for: indexPath) as! SaifonAnnouncementTVCell
                
                // Configure the cell...
                // cell
                
                return cell
            }
        }
        else {
            //loading
            let cell: SaifonAnnouncementTVCell = tableView.dequeueReusableCell(withIdentifier: "SaifonAnnounceLoadingCellID", for: indexPath) as! SaifonAnnouncementTVCell
            
            // Configure the cell... 
            
            return cell
        }
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        selectedData = arrayedData?.object(at: indexPath.row) as? NSDictionary ?? [:]
        
        self.performSegue(withIdentifier: "DB_GOTO_SAIFON_DETAILS", sender: self)
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
        let segue: SaifonAnnouncementDetailsTVC = segue.destination as! SaifonAnnouncementDetailsTVC
        
        segue.detailsData = selectedData!
    }
    

}

class SaifonAnnouncementTVCell: UITableViewCell {
    
    @IBOutlet private weak var uiivSATVCLogo: UIImageView!
    @IBOutlet private weak var uilSATVCAnnouncer: UILabel!
    @IBOutlet private weak var uilSATVCDateAnnounce: UILabel!
    @IBOutlet private weak var uilSATVCShortDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateCell(data: NSDictionary) {
        
        uilSATVCAnnouncer.text = data.value(forKey: "ANNOUNCER") as? String ?? "N/A"
        uilSATVCDateAnnounce.text = data.value(forKey: "DATE") as? String ?? "N/A"
        uilSATVCShortDesc.text = data.value(forKey: "DESC") as? String ?? "N/A"
        
    }
    
}
