//
//  LoginProcessingVC.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 06/12/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import PKHUD

class LoginProcessingVC: UIViewController {
    
    var loginData: NSDictionary? = nil
    var loginDataFB: NSDictionary? = nil
    var newRegFB: NSMutableDictionary? = nil
    
    let fbRegistrationNotification = Notification.Name("performFBRegister")
    let notificationName = Notification.Name("performLogin")
    let tokenMySoalRetrieval = Notification.Name("tokenForMySoal")
    let tokenMySkoolRetrieval = Notification.Name("tokenForMySkool")

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(registerUserFBResult(data:)), name: fbRegistrationNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(loginProcess(data:)), name: notificationName, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(tokenForMySoal(data:)), name: tokenMySoalRetrieval, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(tokenForMySkool(data:)), name: tokenMySkoolRetrieval, object: nil)
        
        HUD.show(HUDContentType.labeledProgress(title: "", subtitle: "Sedang Memuatkan..."))
        
        ZGraphics.applyGradientColorAtView(mainView: self.view, colorSet: DBColorSet.loginColorSet())
        
        if(loginData != nil && DBWebServices.checkConnectionToDashboard(viewController: self) == true) {
            DBWebServices.getLoginData(fromViewController: self, data: loginData!, registeredNotification: notificationName.rawValue)
        }
        else if(DBWebServices.checkConnectionToDashboard(viewController: self) == true) {
            DBWebServices.getLoginFBData(data: loginDataFB!, registeredNotification: notificationName.rawValue)
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        HUD.hide()
    }
    
    func loginProcess(data: NSDictionary)
    {
        print("[LPVC] Processing login with data is \(data)...")
        
        let breakDown = data.value(forKey: "object") as! NSDictionary
        
        let isSuccess = Int(breakDown.value(forKey: "success") as! Int)
        
        let errorCodeString: String? = String(describing: breakDown.value(forKey: "error_code") ?? "0")
        let errorCode: Int = Int(errorCodeString!)!
        
        if(isSuccess == 1) {
            
            print("[LPVC] Login is success...")
            
            UserDefaults.standard.set(true, forKey: "SuccessLoggerIsLogin")
            UserDefaults.standard.set(true, forKey: "SuccessLoggerIsLogin")
            UserDefaults.standard.set(breakDown.value(forKey: "email") ?? "", forKey: "SuccessLoggerEmail")
            UserDefaults.standard.set(breakDown.value(forKey: "full_name") ?? "", forKey: "SuccessLoggerFullName")
            UserDefaults.standard.set(breakDown.value(forKey: "ic_no") ?? "", forKey: "SuccessLoggerICNo")
            UserDefaults.standard.set(breakDown.value(forKey: "message") ?? "", forKey: "SuccessLoggerMessage")
            UserDefaults.standard.set(breakDown.value(forKey: "site_id") ?? "", forKey: "SuccessLoggerSiteID")
            UserDefaults.standard.set(breakDown.value(forKey: "site_name") ?? "", forKey: "SuccessLoggerSiteName")
            UserDefaults.standard.set(breakDown.value(forKey: "sitecode") ?? "" , forKey: "SuccessLoggerSiteCode")
            UserDefaults.standard.set(breakDown.value(forKey: "success") ?? 1, forKey: "SuccessLoggerLoginStatus")
            UserDefaults.standard.set(breakDown.value(forKey: "token") ?? "", forKey: "SuccessLoggerDashboardToken")
            
            //Perform to get MySoal Token
            DBWebServices.getMySoalToken(registeredNotification: tokenMySoalRetrieval.rawValue)
            DBWebServices.getMySkoolToken(registeredNotification: tokenMySkoolRetrieval.rawValue)
            
            //Set Default settings if not available
            if(UserDefaults.standard.object(forKey: "SuccessLoggerSettingsRememberMe") == nil)
            {
                UserDefaults.standard.set(true, forKey: "SuccessLoggerSettingsRememberMe")
            }
            
            if(UserDefaults.standard.object(forKey: "SuccessLoggerSettingsLanguage") == nil)
            {
                UserDefaults.standard.set("MY", forKey: "SuccessLoggerSettingsLanguage")
            }
            
            if(UserDefaults.standard.object(forKey: "SuccessLoggerSettingsModuleSelected") == nil)
            {
                UserDefaults.standard.set(AppDelegate.moduleAvailable, forKey: "SuccessLoggerSettingsModuleSelected")
            }
            
            NotificationCenter.default.removeObserver(self, name: notificationName, object: nil);
        }
        else if(errorCode == 702) {
            
            // unregistered user login from fb need to register
            
            HUD.hide()
            
            self.getUserICDialogAction(confirmed: false, icString: "")
            
        }
        else {
            
            print("[LPVC] Login has error, error code found is \(errorCode) ...")
            
            UserDefaults.standard.set(false, forKey: "SuccessLoggerIsLogin")
            UserDefaults.standard.set(false, forKey: "RememberLogger")
            UserDefaults.standard.set(breakDown.value(forKey: "message"), forKey: "FailedLoggerMessage")
            UserDefaults.standard.set(breakDown.value(forKey: "success"), forKey: "FailedLoggerLoginStatus")
            
            HUD.hide()
            
            let manager = FBSDKLoginManager()
            manager.logOut()
            
            ZUIs.showOKDialogBox(viewController: self, dialogTitle: DBStrings.DB_PROCESS_ERROR_TITLE_MS, dialogMessage: DBStrings.DB_PROCESS_ERROR_DESC_MS, afterDialogDismissed: "BACK_TO_PREVIOUS_VIEWCONTROLLER")
 
            NotificationCenter.default.removeObserver(self, name: notificationName, object: nil);
        }
        
        
    }
    
    //deprecated, go to loginselectorviewcontroller
    func loginProcessFB(notificationName: String) {
        
        FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields":"email, name, first_name, last_name"]).start(completionHandler: { (conn, result, err) -> Void in
            
            if(err == nil) {
                
                let fbDataAcquired: NSDictionary = result as! NSDictionary
                
                let allDataRequired: NSDictionary = ["USERNAME":"",
                                                     "PASSWORD":"",
                                                     "REGISTERED_ID":"1",
                                                     "IMEI":ZDeviceInfo.getDeviceVendorIdentifier(replaced: false),
                                                     "OS":UIDevice.current.systemName,
                                                     "OS_VERSION":UIDevice.current.systemVersion,
                                                     "TYPE_LOGIN":"fb",
                                                     "SITE_ID":"1229",
                                                     "FB_ID":fbDataAcquired.value(forKey: "id")!,
                                                     "FB_TOKEN":FBSDKAccessToken.current().tokenString]
                
                print("[LPVC] Data to send is \(allDataRequired)")
                
                DBWebServices.getLoginFBData(data: allDataRequired, registeredNotification: notificationName)
                
            }
            else {
                
                print("[LPVC] FB Error fetched is \(String(describing: err))")
                
                let manager = FBSDKLoginManager()
                manager.logOut()
                
                ZUIs.showOKDialogBox(viewController: self, dialogTitle: DBStrings.DB_PROCESS_FB_LOGIN_ERROR_TITLE_MS, dialogMessage: DBStrings.DB_PROCESS_FB_LOGIN_ERROR_DESC_MS, afterDialogDismissed: "BACK_TO_PREVIOUS_VIEWCONTROLLER")
            
                
                
            }
            
            
        })
        
    }
    
    func getUserICDialogAction(confirmed: Bool, icString: String) {
        
        if(confirmed == false) {
        
            let icAlertController: UIAlertController = UIAlertController.init(title: DBStrings.DB_USER_REG_FB_FIELD_ZERO_FILL_IC_TITLE_MS, message: DBStrings.DB_USER_REG_FB_FIELD_ZERO_FILL_IC_DESC_MS, preferredStyle: UIAlertControllerStyle.alert)
        
            let cancelAction: UIAlertAction = UIAlertAction.init(title: DBStrings.DB_BUTTON_CANCEL_LABEL_MS, style: UIAlertActionStyle.cancel, handler: { action -> Void in
            
                let manager = FBSDKLoginManager()
                manager.logOut()
            
                ZUIs.showOKDialogBox(viewController: self, dialogTitle: DBStrings.DB_PROCESS_FB_REG_CANCEL_ERROR_TITLE_MS, dialogMessage: DBStrings.DB_PROCESS_FB_REG_CANCEL_ERROR_DESC_MS, afterDialogDismissed: "BACK_TO_PREVIOUS_VIEWCONTROLLER")
            
            })
        
            icAlertController.addAction(cancelAction)
        
            let okAction: UIAlertAction = UIAlertAction.init(title: DBStrings.DB_BUTTON_OK_LABEL_MS, style: UIAlertActionStyle.default, handler: { action -> Void in
                
                let icStringPreferred: String = String(describing: icAlertController.textFields![0].text!).trimmingCharacters(in: NSCharacterSet.whitespaces)
                
                if(icStringPreferred != "") {
                    
                    let icConfirmAlertController: UIAlertController = UIAlertController.init(title: DBStrings.DB_USER_REG_FB_FIELD_ZERO_CONFIRM_IC_TITLE_MS, message: "\(DBStrings.DB_USER_REG_FB_FIELD_ZERO_CONFIRM_IC_DESC_MS) \(icStringPreferred)", preferredStyle: UIAlertControllerStyle.alert)
                
                    let noAction: UIAlertAction = UIAlertAction.init(title: DBStrings.DB_BUTTON_RETRY_LABEL_MS, style: UIAlertActionStyle.cancel, handler: { action -> Void in
                    
                        self.getUserICDialogAction(confirmed: false, icString: "")
                    
                    })
                
                    icConfirmAlertController.addAction(noAction)
                
                    let yesAction: UIAlertAction = UIAlertAction.init(title: DBStrings.DB_BUTTON_CONFIRM_LABEL_MS, style: UIAlertActionStyle.default, handler: { action -> Void in
                    
                        self.getUserICDialogAction(confirmed: true, icString: icStringPreferred)
                    
                    })
                
                    icConfirmAlertController.addAction(yesAction)
                    icConfirmAlertController.preferredAction = yesAction
                
                    self.present(icConfirmAlertController, animated: true, completion: nil)
                    
                }
                else {
                    
                    self.getUserICDialogAction(confirmed: false, icString: "")
                    
                }
            })
        
            icAlertController.addAction(okAction)
            icAlertController.preferredAction = okAction
        
            icAlertController.addTextField(configurationHandler: { (textField : UITextField!) -> Void in
            
                textField.placeholder = DBStrings.DB_USER_REG_FB_FIELD_ZERO_PLACEHOLDER_IC_TITLE_MS
                
            })
        
            self.present(icAlertController, animated: true, completion: nil)
        }
        else {
            
            FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields":"email, name, first_name, last_name"]).start(completionHandler: { (conn, result, err) -> Void in
                
                if(err == nil) {
                    
                    let fbDataAcquired: NSDictionary = result as! NSDictionary
                    
                    let registrationData: NSDictionary = ["REG_USERNAME":icString,
                                                          "REG_PASSWORD":"",
                                                          "REG_OS":UIDevice.current.systemName,
                                                          "REG_ID":"1",
                                                          "REG_OS_VERSION":UIDevice.current.systemVersion,
                                                          "REG_IMEI":ZDeviceInfo.getDeviceVendorIdentifier(replaced: false),
                                                          "REG_TYPE_LOGIN":"fb",
                                                          "REG_FB_ID":fbDataAcquired.value(forKey: "id")!,
                                                          "REG_FB_TOKEN":FBSDKAccessToken.current().tokenString,
                                                          "REG_SITE_ID":"1229",
                                                          "REG_FULL_NAME":fbDataAcquired.value(forKey: "name")!,
                                                          "REG_EMAIL":fbDataAcquired.value(forKey: "email")!]
                    
                    print("RegDataFetched: \(registrationData)")
                    self.registerUserFB(registrationData: registrationData)
                    
                }
                else {
                    
                    print("[LPVC] FB Error fetched is \(String(describing: err))")
                    
                    let manager = FBSDKLoginManager()
                    manager.logOut()
                    
                    ZUIs.showOKDialogBox(viewController: self, dialogTitle: DBStrings.DB_PROCESS_FB_LOGIN_ERROR_TITLE_MS, dialogMessage: DBStrings.DB_PROCESS_FB_LOGIN_ERROR_DESC_MS, afterDialogDismissed: "BACK_TO_PREVIOUS_VIEWCONTROLLER")
                    
                }
                
            })
            
        }
        
    }
    
    func registerUserFB(registrationData: NSDictionary) {
        
        HUD.show(HUDContentType.labeledProgress(title: "", subtitle: "Sedang mendaftarkan..."))
        
        DBWebServices.getRegistrationFBData(fromViewController: self, data: registrationData, registeredNotification: fbRegistrationNotification.rawValue)
        
    }
    
    func registerUserFBResult(data: NSDictionary) {
        
        let breakDown = data.value(forKey: "object") as! NSDictionary
        
        print("[LoginProcessingVC] Data has returned: \(data)")
        
        if(breakDown.value(forKey: "success") as! Int == 1) {
            
            HUD.hide()
            
            //ZUIs.showOKDialogBox(viewController: self, dialogTitle: DBStrings.DB_USER_REG_FB_SUCCESS_TITLE_MS, dialogMessage: DBStrings.DB_USER_REG_FB_SUCCESS_DESC_MS, afterDialogDismissed: nil)
            
            print("logindata: \(String(describing: loginDataFB))")
            
            HUD.show(HUDContentType.labeledProgress(title: "", subtitle: "Sedang Memuatkan..."))
            
            if(loginData != nil && DBWebServices.checkConnectionToDashboard(viewController: self) == true) {
                DBWebServices.getLoginData(fromViewController: self, data: loginData!, registeredNotification: notificationName.rawValue)
            }
            else if(DBWebServices.checkConnectionToDashboard(viewController: self) == true) {
                DBWebServices.getLoginFBData(data: loginDataFB!, registeredNotification: notificationName.rawValue)
            }
            
        }
        else {
            
            HUD.hide()
            
            let manager = FBSDKLoginManager()
            manager.logOut()
            
            ZUIs.showOKDialogBox(viewController: self, dialogTitle: DBStrings.DB_USER_REG_FB_FAILED_TITLE_MS, dialogMessage: DBStrings.DB_USER_REG_FB_FAILED_DESC_MS, afterDialogDismissed: "BACK_TO_PREVIOUS_VIEWCONTROLLER")
            
        }
        
        NotificationCenter.default.removeObserver(self, name: fbRegistrationNotification, object: nil);
        
    }
    
    func tokenForMySoal(data: NSDictionary)
    {
        let breakDown = data.value(forKey: "object") as! NSDictionary
        
        UserDefaults.standard.set(breakDown.value(forKey: "token"), forKey: "SuccessLoggerMySoalToken")
        
        NotificationCenter.default.removeObserver(self, name: tokenMySoalRetrieval, object: nil);
        
    }
    
    func tokenForMySkool(data: NSDictionary)
    {
        let breakDown = data.value(forKey: "object") as! NSDictionary
        
        UserDefaults.standard.set(breakDown.value(forKey: "token"), forKey: "SuccessLoggerMySkoolToken")
        
        NotificationCenter.default.removeObserver(self, name: tokenMySkoolRetrieval, object: nil);
        
        self.finalizingToMainMenu()
    }
    
    func finalizingToMainMenu() {
        
        UserDefaults.standard.set(true, forKey: "RememberLogger")
        self.performSegue(withIdentifier: "DB_GOTO_MAINMENU", sender: self)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if(segue.identifier == "DB_GOTO_MAINMENU") {
            
            /*
            let mainMenu: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let mainMenuTVC: AfterLoginNC = mainMenu.instantiateViewController(withIdentifier: "AfterLoginStoryBoard") as! AfterLoginNC
            let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

            appDelegate.window?.rootViewController = mainMenuTVC
             */
            
            let destinationVC: AfterLoginNC = segue.destination as! AfterLoginNC
        }
        
    }
    */

}
