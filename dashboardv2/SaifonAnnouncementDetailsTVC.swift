//
//  SaifonAnnouncementDetailsTVC.swift
//  dashboardKB
//
//  Created by Mohd Zulhilmi Mohd Zain on 09/03/2018.
//  Copyright © 2018 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class SaifonAnnouncementDetailsTVC: UITableViewController {

    var detailsData: NSDictionary = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        //self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView.estimatedRowHeight = 100.0
        
        ZGraphics.hideTableSeparatorAfterLastCell(tableView: self.tableView)
        
        print("[selecteddata] \(detailsData)")
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
        return 2
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == 0){
            let cell: SaifonAnnouncementDetailsTVCell = tableView.dequeueReusableCell(withIdentifier: "SaifonAnnounceDetailsSenderCellID", for: indexPath) as! SaifonAnnouncementDetailsTVCell
            
            // Configure the cell...
            cell.updateCellHeader(data: detailsData)
            
            return cell
        }
        else {
            let cell: SaifonAnnouncementDetailsTVCell = tableView.dequeueReusableCell(withIdentifier: "SaifonAnnounceDetailsDescCellID", for: indexPath) as! SaifonAnnouncementDetailsTVCell
            
            // Configure the cell...
            cell.updateCellDesc(data: detailsData)
            
            return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

class SaifonAnnouncementDetailsTVCell: UITableViewCell {
    
    @IBOutlet private weak var uivSADTVCAnnouncerLogo: UIImageView!
    @IBOutlet private weak var uilSADTVCAnnouncer: UILabel!
    @IBOutlet private weak var uilSADTVCDateArticle: UILabel!
    @IBOutlet private weak var uilSADTVCFullDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateCellHeader(data: NSDictionary) {
        uilSADTVCAnnouncer.text = data.value(forKey: "ANNOUNCER") as? String ?? "N/A"
        uilSADTVCDateArticle.text = data.value(forKey: "DATE") as? String ?? "0000-00-00 00:00:00"
        
    }
    
    func updateCellDesc(data: NSDictionary) {
        uilSADTVCFullDesc.text = data.value(forKey: "DESC") as? String ?? "N/A"
    }
    
}
