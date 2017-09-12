//
//  MyKomunitiSendMessageTVC.swift
//  dashboardKB
//
//  Created by Mohd Zulhilmi Mohd Zain on 13/03/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
import BSImagePicker
import Photos
import PKHUD

class MyKomunitiSendMessageTVC: UITableViewController, UITextViewDelegate {

    var firstTimeEditing: Bool = false
    var imagePickCell: MyKomunitiSendMessageTVCell? = nil
    
    var imageGrabbed: NSArray = []
    
    var contentText: String = ""
    
    var msgTextView: UITextView = UITextView.init()
    
    var beganEditing: Bool = false
    
    var imageNumber: Int = 0
    
    let registeredNotification: String = "MYKomunitiImgPickNotification"
    let registeredSendMsgNoti: String = "MYKomunitiSendMsgNotification"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()

        NotificationCenter.default.addObserver(self, selector: #selector(populatePhotos(data:)), name: Notification.Name(registeredNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(sendResult(data:)), name: Notification.Name(registeredSendMsgNoti), object: nil)
        
        ZUISetup.setupTableView(tableView: self)
        self.tableView.estimatedRowHeight = 60
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let buttonImg: UIImage = UIImage.init(named: "ic_plane_white")!
        let sendButton: UIButton = UIButton.init(type: UIButtonType.system)
        //sendButton.setImage(buttonImg, for: UIControlState.normal)
        sendButton.setTitle(DBStrings.DB_MODULE_MYKOMUNITI_MSG_SEND_MS, for: UIControlState.normal)
        sendButton.addTarget(self, action: #selector(processingItem(sender:)), for: UIControlEvents.touchUpInside)
        sendButton.frame = CGRect.init(x: 0, y: 0, width: 50, height: 50)
        
        let barBtnItem: UIBarButtonItem = UIBarButtonItem.init(customView: sendButton)
        //let barBtnSystem: UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .camera , target: self, action: #selector(processingItem(sender:)))
        
        self.navigationItem.rightBarButtonItem = barBtnItem
        
        if(msgTextView.text == DBStrings.DB_MODULE_MYKOMUNITI_MSG_PLACEHOLDER_MS) {
            
            msgTextView.textColor = UIColor.lightGray
            
        }
        else {
            msgTextView.textColor = UIColor.black
        }
    }
    
    func processingItem(sender: UIButton) {
        
        print("[MyKomunitiSendMessageTVC] Sending message of \(contentText) with pictures \(imageGrabbed)")
        
        msgTextView.resignFirstResponder()
        
        HUD.show(HUDContentType.progress)
        
        DBWebServices.sentAnnouncementMyKomuniti(registeredNotification: registeredSendMsgNoti , images: imageGrabbed, content: contentText)
        
        //self.navigationController?.popViewController(animated: true)
    }
    
    func populatePhotos(data: NSDictionary) {
        
        print("[MyKomunitiSendMessageTVC] image returned is \(data)")
        
        let unwrappedObject: NSArray = data.value(forKey: "object") as! NSArray
        
        if(unwrappedObject.count != 0) {
            
            imageGrabbed = unwrappedObject
            
            DispatchQueue.main.async {
             
                self.tableView.reloadData()
                
            }
        }
    }
    
    func sendResult(data: NSDictionary) {
        
        print("[MyKomunitiSendMessageTVC] result from sending annoucement is \(data)")
        
        let unwrappedObject: NSDictionary = data.value(forKey: "object") as! NSDictionary
        
        if(unwrappedObject.value(forKey: "status") as! Int == 0 ) {
            
            DispatchQueue.main.async {
                
                //ZUIs.showOKDialogBox(viewController: self, dialogTitle: "Gagal dihantar", dialogMessage: "Terdapat masalah teknikal. Sila cuba sebentar lagi.", afterDialogDismissed: nil)
                
                HUD.flash(HUDContentType.label("Sila cuba sebentar lagi."), delay: 2.0)
            }
        }
        else {
            
            DispatchQueue.main.async {
                
                //ZUIs.showOKDialogBox(viewController: self, dialogTitle: "Diterima", dialogMessage: "Pesanan telah dihantar.", afterDialogDismissed: "BACK_TO_NOT_ROOT_VIEWCONTROLLER")
                
                HUD.flash(HUDContentType.success, delay: 2.0) { _ in self.navigationController!.popViewController(animated: true) }
                
            }
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if(firstTimeEditing == false) {
            textView.text = ""
            textView.textColor = UIColor.black
            firstTimeEditing = true
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        if(imageGrabbed.count != 0) {
            return 3
        }
        else {
            
            return 2
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if(imageGrabbed.count != 0) {
            
            if(section == 0) { return 1 }
            else if(section == 1) { return imageGrabbed.count }
            else { return 1 }
        }
        else {
            
            if(section == 0) { return 1 }
            else { return 1 }
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //MyKomunitiAddPicCellID
        
        if(imageGrabbed.count != 0) {
            
            if(indexPath.section == 2) {
                
                imagePickCell = tableView.dequeueReusableCell(withIdentifier: "MyKomunitiAddPicCellID") as? MyKomunitiSendMessageTVCell
                
                // Configure the cell...
                imagePickCell!.selectionStyle = UITableViewCellSelectionStyle.default
                tableView.allowsSelection = true
                
                return imagePickCell!
            }
            else if(indexPath.section == 1) {
                
                let cell: MyKomunitiSendMessageTVCell = tableView.dequeueReusableCell(withIdentifier: "MyKomunitiPictureContentCellID") as! MyKomunitiSendMessageTVCell
                
                // Configure the cell...
                cell.updateImageCell(data: imageGrabbed.object(at: indexPath.row) as! UIImage)
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                
                return cell
            }
            else {
                
                let cell: MyKomunitiSendMessageTVCell = tableView.dequeueReusableCell(withIdentifier: "MyKomunitiComposeMsgContentCellID") as! MyKomunitiSendMessageTVCell
                
                // Configure the cell...
                cell.setMsgContent()
                cell.uitvMSTVCMsgContent.delegate = self
                //cell.uitvMSTVCMsgContent.textColor = UIColor.lightGray
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                
                return cell
            }
            
        }
        else {
            
            if(indexPath.section == 1) {
            
                imagePickCell = tableView.dequeueReusableCell(withIdentifier: "MyKomunitiAddPicCellID") as? MyKomunitiSendMessageTVCell
            
                // Configure the cell...
                imagePickCell!.selectionStyle = UITableViewCellSelectionStyle.default
            
                return imagePickCell!
            }
            else {
            
                let cell: MyKomunitiSendMessageTVCell = tableView.dequeueReusableCell(withIdentifier: "MyKomunitiComposeMsgContentCellID") as! MyKomunitiSendMessageTVCell
            
                // Configure the cell...
                cell.setMsgContent()
                cell.uitvMSTVCMsgContent.delegate = self
                msgTextView = cell.uitvMSTVCMsgContent
                cell.uitvMSTVCMsgContent.textColor = UIColor.lightGray
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                
                if(cell.uitvMSTVCMsgContent.text == "" || firstTimeEditing == false) {
                    
                    cell.uitvMSTVCMsgContent.text = DBStrings.DB_MODULE_MYKOMUNITI_MSG_PLACEHOLDER_MS
                    
                }
            
                return cell
            }
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        print("[MyKomunitiSendMessageTVC] Returned text is \(textView.text)")
        
        contentText = textView.text
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if(imageGrabbed.count != 0) {
        
            if(indexPath.section == 2)
            {
                imagePickCell!.setAddImageBtn(parentViewController: self, notificationName: registeredNotification)
            }
            else if(indexPath.section == 1)
            {
                imageNumber = indexPath.row
                //self.performSegue(withIdentifier: "DB_GOTO_IMAGE_PREVIEW", sender: self)
            }
        
        }
        else {
            
            if(indexPath.section == 1)
            {
                imagePickCell!.setAddImageBtn(parentViewController: self, notificationName: registeredNotification)
            }
            
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
        
        let destinationVC: MyKomunitiSendMsgImgPreviewVC = segue.destination as! MyKomunitiSendMsgImgPreviewVC
        
        destinationVC.imageGrabbedFromParent = ["IMAGE_ARRAY_NO": imageNumber, "IMAGE_ARRAY": imageGrabbed]
        
        
    }
    
    @IBAction func acquireDataByUnwind(segue: UIStoryboardSegue) {
        
        if let returnVC: MyKomunitiSendMsgImgPreviewVC = segue.source as? MyKomunitiSendMsgImgPreviewVC {
            
            print("return vc is \(returnVC.imageGrabbedFromParent)")
            
            //imageGrabbed = returnVC.imageGrabbedFromParent.value(forKey: "IMAGE_ARRAY") as! NSArray
            
            //DispatchQueue.main.async {
                
                //self.tableView.reloadData()
                
            //}
            
            
            
        }
        
    }
    

}
