//
//  LoginRegisterProcessVC.swift
//  dashboardKB
//
//  Created by Mohd Zulhilmi Mohd Zain on 01/03/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
import PKHUD

class LoginRegisterProcessVC: UIViewController {
    
    var registrationData: NSDictionary? = nil
    
    let notificationName = Notification.Name("performRegistration")

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        ZGraphics.applyGradientColorAtView(mainView: self.view, colorSet: DBColorSet.loginColorSet())
        
        HUD.show(HUDContentType.labeledProgress(title: "", subtitle: "Sedang mendaftarkan..."))
        
        NotificationCenter.default.addObserver(self, selector: #selector(registerResult(data:)), name: notificationName, object: nil)
        
        DBWebServices.getRegistrationData(fromViewController: self, data: registrationData!, registeredNotification: notificationName.rawValue)
    }
    
    @objc func registerResult(data: NSDictionary) {
        
        let breakDown = data.value(forKey: "object") as! NSDictionary
        
        print("[LoginRegisterVC] Data has returned: \(data)")
        
        if(breakDown.value(forKey: "status") as! String == "success") {
            
            ZUIs.showOKDialogBox(viewController: self, dialogTitle: DBStrings.DB_USER_REG_SUCCESS_TITLE_MS, dialogMessage: DBStrings.DB_USER_REG_SUCCESS_DESC_MS, afterDialogDismissed: "BACK_TO_PREVIOUS_VIEWCONTROLLER")
            
        }
        else {
            
            ZUIs.showOKDialogBox(viewController: self, dialogTitle: DBStrings.DB_USER_REG_FAILED_TITLE_MS, dialogMessage: DBStrings.DB_USER_REG_FAILED_DESC_MS, afterDialogDismissed: "BACK_TO_PREVIOUS_VIEWCONTROLLER")
            
        }
        
        NotificationCenter.default.removeObserver(self, name: notificationName, object: nil);
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
