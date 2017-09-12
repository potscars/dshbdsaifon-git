//
//  MyPlaceSearchFilterVC.swift
//  dashboardKB
//
//  Created by Mohd Zulhilmi Mohd Zain on 27/04/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MyPlaceSearchFilterVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var uitvMPSFVCFilterListing: UITableView!
    
    var buttonCount: Int = 3

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.edgesForExtendedLayout = []
        self.automaticallyAdjustsScrollViewInsets = false
        //self.uitvMPSFVCFilterListing.contentInset = UIEdgeInsetsMake(-65,0,0,0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(section == 1){
            return 1
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(buttonCount >= 2)
        {
            let cell: MyPlaceSearchFilterTVCell = tableView.dequeueReusableCell(withIdentifier: "MPResultFilterTwoBtnCellID") as! MyPlaceSearchFilterTVCell
            
            cell.updateTwoBtn(data: ["FILTER_FIRST_BUTTON":"Recent","FILTER_SECOND_BUTTON":"Favourite"])
            
            buttonCount = buttonCount - 2
        
            return cell
        }
        else {
            
            let cell: MyPlaceSearchFilterTVCell = tableView.dequeueReusableCell(withIdentifier: "MPResultFilterOneBtnCellID") as! MyPlaceSearchFilterTVCell
            
            cell.updateOneBtn(data: ["FILTER_FIRST_BUTTON":"Accommodation"])
            
            buttonCount = buttonCount - 1
            
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if(section == 1) { return "Susun mengikut" } else { return "Tapis mengikut" }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
 
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
