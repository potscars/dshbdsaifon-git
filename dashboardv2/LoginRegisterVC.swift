//
//  LoginRegisterVC.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 21/02/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class LoginRegisterVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var uitfLRVCNameField: UITextField!
    @IBOutlet weak var utifLRVCICField: UITextField!
    @IBOutlet weak var uitfLRVCEmailField: UITextField!
    @IBOutlet weak var uitfLRVCPassField: UITextField!
    @IBOutlet weak var uitfLRVCConfirmPassField: UITextField!

    @IBOutlet weak var uibLRVCCancelRegister: UIButton!
    @IBOutlet weak var uibLRVCConfirmRegister: UIButton!
    
    var textFieldIsEditing: Bool = false
    
    let notificationName = Notification.Name("performRegistration")
    
    var registrationData: NSDictionary? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        ZGraphics.applyGradientColorAtView(mainView: self.view, colorSet: DBColorSet.loginColorSet())
        
        uitfLRVCNameField.delegate = self
        utifLRVCICField.delegate = self
        uitfLRVCEmailField.delegate = self
        uitfLRVCPassField.delegate = self
        uitfLRVCConfirmPassField.delegate = self
        
        uitfLRVCNameField.returnKeyType = UIReturnKeyType.next
        utifLRVCICField.returnKeyType = UIReturnKeyType.next
        uitfLRVCEmailField.returnKeyType = UIReturnKeyType.next
        uitfLRVCPassField.returnKeyType = UIReturnKeyType.next
        uitfLRVCConfirmPassField.returnKeyType = UIReturnKeyType.done
        
        uitfLRVCEmailField.keyboardType = UIKeyboardType.emailAddress
        
        uitfLRVCPassField.isSecureTextEntry = true
        uitfLRVCConfirmPassField.isSecureTextEntry = true
        
        utifLRVCICField.keyboardType = UIKeyboardType.numberPad
        
        uibLRVCCancelRegister.addTarget(self, action: #selector(returnToLogin(button:)), for: UIControlEvents.touchUpInside)
        uibLRVCConfirmRegister.addTarget(self, action: #selector(performRegister(button:)), for: UIControlEvents.touchUpInside)
        
    }
    
    func returnToLogin(button: UIButton) {
        
        _ = self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    func performRegister(button: UIButton) {
        
        if(uitfLRVCNameField.text == "" || uitfLRVCNameField.text == nil) {
            
            ZUIs.showOKDialogBox(viewController: self, dialogTitle: DBStrings.DB_USER_REG_FIELD_ZERO_TITLE_MS, dialogMessage: DBStrings.DB_USER_REG_FIELD_ZERO_FULLNAME_MS, afterDialogDismissed: nil)
            
        }
        else if(utifLRVCICField.text == "" || utifLRVCICField.text == nil){
            
            ZUIs.showOKDialogBox(viewController: self, dialogTitle: DBStrings.DB_USER_REG_FIELD_ZERO_TITLE_MS, dialogMessage: DBStrings.DB_USER_REG_FIELD_ZERO_IC_MS, afterDialogDismissed: nil)
            
        }
        else if(uitfLRVCEmailField.text == "" || uitfLRVCEmailField.text == nil){
            
            ZUIs.showOKDialogBox(viewController: self, dialogTitle: DBStrings.DB_USER_REG_FIELD_ZERO_TITLE_MS, dialogMessage: DBStrings.DB_USER_REG_FIELD_ZERO_EMAIL_MS, afterDialogDismissed: nil)
            
        }
        else if(uitfLRVCPassField.text == "" || uitfLRVCPassField.text == nil){
            
            ZUIs.showOKDialogBox(viewController: self, dialogTitle: DBStrings.DB_USER_REG_FIELD_ZERO_TITLE_MS, dialogMessage: DBStrings.DB_USER_REG_FIELD_ZERO_PASSWORD_MS, afterDialogDismissed: nil)
            
        }
        else if(uitfLRVCConfirmPassField.text == "" || uitfLRVCConfirmPassField.text == nil){
            
            ZUIs.showOKDialogBox(viewController: self, dialogTitle: DBStrings.DB_USER_REG_FIELD_ZERO_TITLE_MS, dialogMessage: DBStrings.DB_USER_REG_FIELD_ZERO_CONFIRM_PASSWORD_MS, afterDialogDismissed: nil)
            
        }
        else if(uitfLRVCConfirmPassField.text! == uitfLRVCPassField.text!) {
            
            registrationData = ["REG_IC_NO":utifLRVCICField.text!,
                            "REG_FULL_NAME":uitfLRVCNameField.text!,
                            "REG_EMAIL":uitfLRVCEmailField.text!,
                            "REG_PASSWORD":uitfLRVCPassField.text!,
                            "REG_SITE_ID":"1229"]
        
            self.performSegue(withIdentifier: "DB_GOTO_REGISTER_PROCESS", sender: self)
        }
        else {
            
            ZUIs.showOKDialogBox(viewController: self, dialogTitle: DBStrings.DB_USER_REG_PASSWORD_UNMATCHED_TITLE_MS, dialogMessage: DBStrings.DB_USER_REG_PASSWORD_UNMATCHED_DESC_MS, afterDialogDismissed: nil)
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if (textFieldIsEditing == false) {
            
            textFieldIsEditing = true
            ZGraphics.moveViewYPosition(view: self.view, yPosition: 100, animationDuration: 0.25, moveToUp: true)
            
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if(uitfLRVCNameField.text != "" && utifLRVCICField.text == "" && uitfLRVCEmailField.text == "" && uitfLRVCPassField.text == "" && uitfLRVCConfirmPassField.text == "") { utifLRVCICField.becomeFirstResponder() }
        else if(uitfLRVCNameField.text != "" && utifLRVCICField.text != "" && uitfLRVCEmailField.text == "" && uitfLRVCPassField.text == "" && uitfLRVCConfirmPassField.text == "") { uitfLRVCEmailField.becomeFirstResponder() }
        else if(uitfLRVCNameField.text != "" && utifLRVCICField.text != "" && uitfLRVCEmailField.text != "" && uitfLRVCPassField.text == "" && uitfLRVCConfirmPassField.text == "") { uitfLRVCPassField.becomeFirstResponder() }
        else if(uitfLRVCNameField.text != "" && utifLRVCICField.text != "" && uitfLRVCEmailField.text != "" && uitfLRVCPassField.text != "" && uitfLRVCConfirmPassField.text == "") { uitfLRVCConfirmPassField.becomeFirstResponder() }
        else if(uitfLRVCNameField.text != "" && utifLRVCICField.text != "" && uitfLRVCEmailField.text != "" && uitfLRVCPassField.text != "" && uitfLRVCConfirmPassField.text != "") {
            
            textFieldIsEditing = false
            ZGraphics.moveViewYPosition(view: self.view, yPosition: 100, animationDuration: 0.25, moveToUp: false)
            
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        uitfLRVCNameField.endEditing(true)
        utifLRVCICField.endEditing(true)
        uitfLRVCEmailField.endEditing(true)
        uitfLRVCPassField.endEditing(true)
        uitfLRVCConfirmPassField.endEditing(true)
        
        return true
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller
        
        if(segue.identifier == "DB_GOTO_REGISTER_PROCESS") {
            
            let destinationVC: LoginRegisterProcessVC = segue.destination as! LoginRegisterProcessVC
            destinationVC.registrationData = self.registrationData!
            
        }
        
    }
    

}
