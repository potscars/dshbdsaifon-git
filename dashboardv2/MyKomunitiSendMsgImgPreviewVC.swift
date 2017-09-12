//
//  MyKomunitiSendMsgImgPreviewVC.swift
//  dashboardKB
//
//  Created by Mohd Zulhilmi Mohd Zain on 29/03/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MyKomunitiSendMsgImgPreviewVC: UIViewController {

    var imageGrabbedFromParent: NSDictionary = [:]
    var getImageArray: NSMutableArray = []
    @IBOutlet weak var uiivMKSMIPVCPrevImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print("ImageGrabbed \(imageGrabbedFromParent)")
        
        getImageArray = imageGrabbedFromParent.value(forKey: "IMAGE_ARRAY") as! NSMutableArray
        
        uiivMKSMIPVCPrevImage.image = getImageArray.object(at: imageGrabbedFromParent.value(forKey: "IMAGE_ARRAY_NO") as! Int) as? UIImage ?? UIImage.init(named:"ic_saifonlogo")
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        let buttonImg: UIImage = UIImage.init(named: "ic_plane_white")!
        let sendButton: UIButton = UIButton.init(type: UIButtonType.system)
        sendButton.setImage(buttonImg, for: UIControlState.normal)
        //sendButton.setTitle(DBStrings.DB_MODULE_MYKOMUNITI_MSG_SEND_MS, for: UIControlState.normal)
        sendButton.addTarget(self, action: #selector(processingItem(sender:)), for: UIControlEvents.touchUpInside)
        sendButton.frame = CGRect.init(x: 0, y: 0, width: 50, height: 50)
        
        let barBtnItem: UIBarButtonItem = UIBarButtonItem.init(customView: sendButton)
        
        self.navigationItem.rightBarButtonItem = barBtnItem
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func processingItem(sender: UIButton) {
        
        let alertView: UIAlertController = UIAlertController.init(title: "Buang", message: "Anda pasti ingin membuang gambar ini?", preferredStyle: UIAlertControllerStyle.alert)
        
        let alertNoAction: UIAlertAction = UIAlertAction.init(title: "Tidak", style: UIAlertActionStyle.default, handler: { (action) in
            
            alertView.dismiss(animated: true, completion: { (Void) in })
            
        })
        
        let alertYesAction: UIAlertAction = UIAlertAction.init(title: "YA", style: UIAlertActionStyle.default, handler: { (action) in
            
            self.getImageArray.removeObject(at: self.imageGrabbedFromParent.value(forKey: "IMAGE_ARRAY_NO") as! Int)
            
            self.imageGrabbedFromParent = ["IMAGE_ARRAY_NO": self.imageGrabbedFromParent.value(forKey: "IMAGE_ARRAY_NO") as! Int, "IMAGE_ARRAY": self.getImageArray]
            
            _ = self.navigationController?.popViewController(animated: true)
            
            alertView.dismiss(animated: true, completion: { (Void) in })
            
        })
        
        alertView.addAction(alertNoAction)
        alertView.addAction(alertYesAction)
        
        self.present(alertView, animated: true, completion: nil)
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
