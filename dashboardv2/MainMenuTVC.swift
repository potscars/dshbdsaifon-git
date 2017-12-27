//
//  MainMenuTVC.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 27/12/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MainMenuTVC: UITableViewController {
    
    //let menuArrays: NSMutableArray = []
    
    @IBOutlet var uitvMMTVCMenuLists: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        DBWebServices.checkConnectionToDashboard(viewController: self)
        
        AppDelegate.mainMenuController = self
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView.estimatedRowHeight = 120.0
        self.edgesForExtendedLayout = []
        self.tableView.backgroundColor = DBColorSet.dashboardKBTertiaryColor
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        let leftBtnItem: UIBarButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "ic_profile.png"), style: .plain, target: self, action: #selector(gotoProfile))
        self.navigationItem.leftBarButtonItem = leftBtnItem
        
        let rightBtnItem: UIBarButtonItem = UIBarButtonItem.init(title: "\u{2699}", style: .plain, target: self, action: #selector(gotoSettings))
        self.navigationItem.rightBarButtonItem = rightBtnItem
        
        let backButtonItem: UIBarButtonItem = UIBarButtonItem()
        backButtonItem.title = DBStrings.DB_BUTTON_BACK_LABEL_MS
        self.navigationItem.backBarButtonItem = backButtonItem
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("[MainMenuTVC] Settings registered:\n\nRemember Me: \(UserDefaults.standard.object(forKey: "SuccessLoggerSettingsRememberMe") as! Bool)\nLanguage Selected: \(UserDefaults.standard.object(forKey: "SuccessLoggerSettingsLanguage") as! String)\nModule Selected: \(UserDefaults.standard.object(forKey: "SuccessLoggerSettingsModuleSelected") as! NSArray)")
        
        ZGraphics.applyNavigationBarColor(controller: self, setBarTintColor: DBColorSet.dashboardKBTertiaryColor, setBackButtonFontColor: UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0), setBarFontColor: UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0), setBarFontFace: UIFont.init(name: "Arial-BoldMT", size: CGFloat(17.0))!)
    }
    
    func gotoSettings(sender: UIEvent)
    {
        print("[MainMenuTVC] Open settings \(sender)!")
        
        self.performSegue(withIdentifier: "DB_GOTO_SETTINGS", sender: self)
    }
    
    @objc func gotoProfile(sender: UIEvent) {
        
        self.performSegue(withIdentifier: "DB_GOTO_PROFILE", sender: self)
        
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
        return DBMenus.dashboardFrontMenu().count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == 0) {
            
            //tableView.estimatedRowHeight = 150.0
            
            let cell: MMImageTransTVCell = tableView.dequeueReusableCell(withIdentifier: "MMImageCellID") as! MMImageTransTVCell
            
            // Configure the cell...
            
            cell.updateCell()
            
            return cell
            
        }
        else {
            
            //tableView.estimatedRowHeight = 120.0
            
            let cell: MMMenuListTVCell = tableView.dequeueReusableCell(withIdentifier: "MMMenuGridCellID") as! MMMenuListTVCell

            // Configure the cell...
        
            cell.updateCell(data: DBMenus.dashboardFrontMenu().object(at: indexPath.row) as! NSDictionary)

            return cell
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if(indexPath.row == 0 && DBWebServices.checkConnectionToDashboard(viewController: self) == true)
        {
            self.performSegue(withIdentifier: "DB_GOTO_ABOUT", sender: self)
        }
        else if(indexPath.row == 1 && DBWebServices.checkConnectionToDashboard(viewController: self) == true)
        {
            self.performSegue(withIdentifier: "DB_GOTO_MYKOMUNITI", sender: self)
            
        }
        else if(indexPath.row == 2 && DBWebServices.checkConnectionToDashboard(viewController: self) == true)
        {
            self.performSegue(withIdentifier: "DB_GOTO_MYSOAL", sender: self)
            
        }
        else if(indexPath.row == 3 && DBWebServices.checkConnectionToDashboard(viewController: self) == true)
        {
            self.performSegue(withIdentifier: "DB_GOTO_MYSKOOL", sender: self)
            
        }
        else if(indexPath.row == 4 && DBWebServices.checkConnectionToDashboard(viewController: self) == true)
        {
            self.performSegue(withIdentifier: "DB_GOTO_WATERLEVEL", sender: self)
            
        }
        else if(indexPath.row == 5 && DBWebServices.checkConnectionToDashboard(viewController: self) == true)
        {
            self.performSegue(withIdentifier: "DB_GOTO_WEATHER", sender: self)
            
        }
//        else if(indexPath.row == 4 && DBWebServices.checkConnectionToDashboard(viewController: self) == true)
//        {
//            self.performSegue(withIdentifier: "DB_GOTO_MYPLACE", sender: self)
//            
//        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
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
