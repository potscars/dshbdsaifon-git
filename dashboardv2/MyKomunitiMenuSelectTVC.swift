//
//  MyKomunitiMenuSelectTVC.swift
//  dashboardKB
//
//  Created by Mohd Zulhilmi Mohd Zain on 13/03/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MyKomunitiMenuSelectTVC: UITableViewController {
    
    var mailMenuListSection1: NSArray = ["Awam","Pentadbir"]
    var mailMenuListSection2: NSArray = ["Hantar Pesanan"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        ZGraphics.applyNavigationBarColor(controller: self, setBarTintColor: DBColorSet.dashboardKBTertiaryColor, setBackButtonFontColor: UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0), setBarFontColor: UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0), setBarFontFace: UIFont.init(name: "Arial-BoldMT", size: CGFloat(17.0))!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if(section == 0)
        {
            return mailMenuListSection1.count
        }
        else
        {
            return mailMenuListSection2.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: MyKomunitiMenuSelectTVCell = tableView.dequeueReusableCell(withIdentifier: "MyKomunitiMailMenuCellID") as! MyKomunitiMenuSelectTVCell

        // Configure the cell...
        if(indexPath.section == 0){
            cell.textLabel?.text = mailMenuListSection1.object(at: indexPath.row) as? String
            
            cell.imageView?.image = UIImage.init(named: "ic_mailbox")
        }
        else {
            cell.textLabel?.text = mailMenuListSection2.object(at: indexPath.row) as? String
            
            cell.imageView?.image = UIImage.init(named: "ic_new_message")
            cell.accessoryType = UITableViewCellAccessoryType.none
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if(indexPath.section == 0 && indexPath.row == 0)
        {
            self.performSegue(withIdentifier: "DB_GOTO_MYKOMUNITI_AWAM", sender: self)
        }
        else if(indexPath.section == 0 && indexPath.row == 1)
        {
            self.performSegue(withIdentifier: "DB_GOTO_MYKOMUNITI_PENTADBIR", sender: self)
        }
        else {
            self.performSegue(withIdentifier: "DB_GOTO_MYKOMUNITI_COMPOSE_MSG", sender: self)
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
