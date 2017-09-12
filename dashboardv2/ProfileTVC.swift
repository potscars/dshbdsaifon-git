//
//  ProfileTVC.swift
//  dashboardKB
//
//  Created by Mohd Zulhilmi Mohd Zain on 25/03/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class ProfileTVC: UITableViewController {
    
    var profileUserLabel: NSArray = []
    var profileUserData: NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 60.0
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        ZGraphics.applyNavigationBarColor(controller: self, setBarTintColor: DBColorSet.dashboardKBTertiaryColor, setBackButtonFontColor: UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0), setBarFontColor: UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0), setBarFontFace: UIFont.init(name: "Arial-BoldMT", size: CGFloat(17.0))!)
        
        profileUserLabel = ["Nama:","Nombor Kad Pengenalan:", "Emel:", "Komuniti:"]
    
        profileUserData = [String(describing: UserDefaults.standard.object(forKey: "SuccessLoggerFullName")!), String(describing: UserDefaults.standard.object(forKey: "SuccessLoggerICNo")!), String(describing: UserDefaults.standard.object(forKey: "SuccessLoggerEmail")!), String(describing: UserDefaults.standard.object(forKey: "SuccessLoggerSiteName")!)]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func finishView(sender: UIEvent) {
        
        self.dismiss(animated: true, completion: nil)
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return profileUserData.count + 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row < profileUserData.count) {
            
            print("\(indexPath.row) of \(profileUserData.count)")
            
            let cell: ProfileIntegratedTVCell = tableView.dequeueReusableCell(withIdentifier: "ProfileDetailsCellID") as! ProfileIntegratedTVCell

            // Configure the cell...
        
            cell.updateProfile(data: ["PROFILE_LABEL":profileUserLabel.object(at: indexPath.row),"PROFILE_DESC":profileUserData.object(at: indexPath.row)])
            cell.selectionStyle = UITableViewCellSelectionStyle.none

            return cell
            
        }
        else {
            
            let cell: ProfileIntegratedTVCell = tableView.dequeueReusableCell(withIdentifier: "ProfileFinishCellID") as! ProfileIntegratedTVCell
            
            // Configure the cell...
            
            cell.uibPTVCFinishBtn.addTarget(self, action: #selector(finishView), for: UIControlEvents.touchUpInside)
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            return cell
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
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
