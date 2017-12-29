//
//  LoginSelectionVCViewController.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 21/02/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginSelectionVC: UIViewController, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var uibLSVCFBLogin: FBSDKLoginButton!
    @IBOutlet weak var uibLSVCICLogin: UIButton!
    @IBOutlet weak var uibLSVCRegister: UIButton!
    
    var dataToSend: NSDictionary = [:]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        ZGraphics.applyGradientColorAtView(mainView: self.view, colorSet: DBColorSet.loginColorSet())
        
        uibLSVCFBLogin.readPermissions = ["public_profile","email"]
        uibLSVCFBLogin.delegate = self
        
        uibLSVCICLogin.addTarget(self, action: #selector(loginWithIC(button:)), for: UIControlEvents.touchUpInside)
        uibLSVCRegister.addTarget(self, action: #selector(openRegister(button:)), for: UIControlEvents.touchUpInside)
        
        applyLanguage(selectedLang: "MS")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if(FBSDKAccessToken.current() != nil) {
            
            self.performSegue(withIdentifier: "DB_GOTO_LOGIN_IC_DIRECT", sender: self)
            
        }
        
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        print("[LSVC] Facebook login success")
        
        if(ZNetwork.isConnectedToNetwork() == true && FBSDKAccessToken.current() != nil) {
            
            print("[LSVC] Facebook has token")
            
            FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields":"email, name, first_name, last_name"]).start(completionHandler: { (conn, result, err) -> Void in
                
                if(err == nil) {
                    
                    print("[LPVC] FB User fetched is \(String(describing: result))")
                    let fbDataAcquired: NSDictionary = result as! NSDictionary
                    print("[LPVC] FB User fetched in dictionary is \(fbDataAcquired)")
                    
                    self.dataToSend = ["USERNAME":"",
                                       "PASSWORD":"",
                                       "REGISTERED_ID":"1",
                                       "IMEI":ZDeviceInfo.getDeviceVendorIdentifier(replaced: false),
                                       "OS":UIDevice.current.systemName,
                                       "OS_VERSION":UIDevice.current.systemVersion,
                                       "TYPE_LOGIN":"fb",
                                       "SITE_ID":"1229",
                                       "FB_ID":fbDataAcquired.value(forKey: "id")!,
                                       "FB_TOKEN":FBSDKAccessToken.current().tokenString]
                    
                    print("[LPVC] Data to send is \(self.dataToSend)")
                    
                    self.performSegue(withIdentifier: "DB_GOTO_LOGIN_IC_DIRECT", sender: self)
                    
                }
                else {
                    
                    print("[LPVC] FB Error fetched is \(String(describing: err))")
                    
                    ZUIs.showOKDialogBox(viewController: self, dialogTitle: DBStrings.DB_PROCESS_FB_LOGIN_ERROR_TITLE_MS, dialogMessage: DBStrings.DB_PROCESS_FB_LOGIN_ERROR_DESC_MS, afterDialogDismissed: nil)
                    
                }
                
            })
            
        }
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
        print("[LSVC] Facebook logout success")
        
    }
    
    @objc func openRegister(button: UIButton) {
        
        if(DBWebServices.checkConnectionToDashboard(viewController: self) == true) { self.performSegue(withIdentifier: "DB_GOTO_REGISTER_USER", sender: self) }
        
    }
    
    @objc func loginWithIC(button: UIButton) {
        
        if(DBWebServices.checkConnectionToDashboard(viewController: self) == true) { self.performSegue(withIdentifier: "DB_GOTO_LOGIN_IC", sender: self) }
        
    }
    
    func applyLanguage(selectedLang: String) {
        
        if(selectedLang == "MS")
        {
            uibLSVCICLogin.setTitle(DBStrings.DB_SELECT_USERNAME_MS, for: UIControlState.normal)
            uibLSVCRegister.setTitle(DBStrings.DB_SELECT_REGISTER_MS, for: UIControlState.normal)
        }
        else
        {
            uibLSVCICLogin.setTitle(DBStrings.DB_SELECT_USERNAME_EN, for: UIControlState.normal)
            uibLSVCRegister.setTitle(DBStrings.DB_SELECT_REGISTER_EN, for: UIControlState.normal)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if(segue.identifier == "DB_GOTO_LOGIN_IC_DIRECT") {
            
            let destinationVC: LoginProcessingVC = segue.destination as! LoginProcessingVC
            destinationVC.loginDataFB = self.dataToSend
            
        }
        
    }
    

}
