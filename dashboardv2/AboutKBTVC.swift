//
//  AboutKBTVC.swift
//  dashboardKB
//
//  AboutKBFirstCellID
//  AboutKBAgenciesCellID
//
//  Created by Mohd Zulhilmi Mohd Zain on 27/03/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class AboutKBTVC: UITableViewController {
    
    let registeredNotification: String = "AboutNotification"
    let registeredPicNotification: String = "AboutPicNotification"
    let agencyData: NSMutableArray = ["INTRO"]
    let cachedImage: NSMutableArray = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        DBWebServices.getAgenciesList(registeredNotification: registeredPicNotification)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(populateData(data:)), name: Notification.Name(registeredNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(populatePicData(data:)), name: Notification.Name(registeredPicNotification), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: Notification.Name(registeredNotification), object: nil);
        NotificationCenter.default.removeObserver(self, name: Notification.Name(registeredPicNotification), object: nil);
    }
    
    func populatePicData(data: NSArray) {
        
        let extractNotificationWrapper: NSArray = data.value(forKey: "object") as! NSArray
        
        for i in 0...extractNotificationWrapper.count - 1 {
            
            let brokeUpData: NSDictionary = extractNotificationWrapper.object(at: i) as! NSDictionary
            let getProfilePic: NSDictionary = brokeUpData.value(forKey: "profile") as! NSDictionary
            let getThumbnail: NSDictionary = getProfilePic.value(forKey: "thumbnail") as! NSDictionary
            
            processImage(url: String(describing: "\(getThumbnail.value(forKey: "domain")!)\(getThumbnail.value(forKey: "full_path")!)"))
        }
        
        
        
        DispatchQueue.main.async {
            
            DBWebServices.getAgenciesList(registeredNotification: self.registeredNotification)
            
        }
        
    }
    
    func populateData(data: NSArray) {
        
        let extractNotificationWrapper: NSArray = data.value(forKey: "object") as! NSArray
        
        for i in 0...extractNotificationWrapper.count - 1 {
            
            let brokeUpData: NSDictionary = extractNotificationWrapper.object(at: i) as! NSDictionary
            let getProfilePic: NSDictionary = brokeUpData.value(forKey: "profile") as! NSDictionary
            let getThumbnail: NSDictionary = getProfilePic.value(forKey: "thumbnail") as! NSDictionary
            
            let arrangedDict: NSDictionary = ["ABOUT_AGENCY_NAME":String(describing: brokeUpData.value(forKey: "name")!),
                                              "ABOUT_AGENCY_EMAIL":String(describing: brokeUpData.value(forKey: "email")!),
                                              "ABOUT_AGENCY_PHONE":String(describing: brokeUpData.value(forKey: "phone_no")!),
                                              "ABOUT_AGENCY_LOGO":String(describing: "\(getThumbnail.value(forKey: "domain")!)\(getThumbnail.value(forKey: "full_path")!)")
            ]
            //"ABOUT_AGENCY_LOGO":self.cachedImage.object(at: i)
            
            agencyData.add(arrangedDict)
        }
        
        
        
        DispatchQueue.main.async {
            
            self.tableView.reloadData()
            
        }
        
    }
    
    func processImage(url: String) {
        
        let imageURL: URL = URL.init(string: url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!
        let session = URLSession(configuration: URLSessionConfiguration.default)
        var imageReturn: UIImage = UIImage.init(named: "ic_saifonlogo")!
        
        let downloadPicTask = session.dataTask(with: imageURL) { (data, response, error) in
            
            if let e = error {
                print("[ZImages] Error downloading picture, using defaultImage instead : \(e)")
            }
            else {
                
                if let res = response as? HTTPURLResponse {
                    print("[ZImages] Response got : \(res.statusCode)")
                    
                    if let imageData = data {
                        
                        self.cachedImage.add(UIImage.init(data: imageData)!)
                        
                    } else if let e = error {
                        
                        print("[ZImages] Error processing image, using defaultImage instead : \(e)")
                        
                    } else {
                        
                        print("[ZImages] Unknown error")
                        
                    }
                    
                }
                else if let e = error {
                    
                    print("[ZImages] Error retrieving response, using defaultImage instead : \(e)")
                    
                }
                
            }
    
        }
        
        downloadPicTask.resume()
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
        
        if(agencyData.count != 0) { return agencyData.count }
        else { return 1 }
            
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == 0) {
            let cell: AboutKBIntegratedTVCell = tableView.dequeueReusableCell(withIdentifier: "AboutKBFirstCellID") as! AboutKBIntegratedTVCell

            // Configure the cell...

            return cell
        }
        else {
            
            let cell: AboutKBIntegratedTVCell = tableView.dequeueReusableCell(withIdentifier: "AboutKBAgenciesCellID") as! AboutKBIntegratedTVCell
            
            // Configure the cell...
            cell.tag = indexPath.row
            
            let getAgencyData: NSDictionary = agencyData.object(at: indexPath.row) as! NSDictionary
            
            cell.updateAgencyInfo(data: getAgencyData)
            
            let getImageURL: String = getAgencyData.value(forKey: "ABOUT_AGENCY_LOGO") as! String
            
            let imageURL: URL = URL.init(string: getImageURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!
            let session = URLSession(configuration: URLSessionConfiguration.default)
            //let imageDef: UIImage = UIImage.init(named: defaultImage)!
            //imageView.image = imageDef
            
            print("[ZImages] ImageURL: \(imageURL)")
            
            let downloadPicTask = session.dataTask(with: imageURL) { (data, response, error) in
                
                if let e = error {
                    print("[ZImages] Error downloading picture, using defaultImage instead : \(e)")
                }
                else {
                    
                    if let res = response as? HTTPURLResponse {
                        print("[ZImages] Response got : \(res.statusCode)")
                        
                        if let imageData = data {
                            
                            if(cell.tag == indexPath.row) {
                            
                                DispatchQueue.main.async() { () -> Void in cell.updateAgencyLogo(image: UIImage.init(data: imageData) ?? UIImage.init(named: "ic_saifonlogo"))  }
                                
                            }
                            
                        } else if let e = error {
                            
                            print("[ZImages] Error processing image, using defaultImage instead : \(e)")
                            
                        } else {
                            
                            print("[ZImages] Unknown error")
                            
                        }
                        
                    }
                    else if let e = error {
                        
                        print("[ZImages] Error retrieving response, using defaultImage instead : \(e)")
                        
                    }
                    
                }
                
                
            }
            
            downloadPicTask.resume()
            
            
            //let imageURL: NSURL = NSURL.init(string: <#T##String#>)
            
            return cell
            
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(indexPath.row == 0) {
            
            return 250
            
        }
        else {
            
            return 110
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
