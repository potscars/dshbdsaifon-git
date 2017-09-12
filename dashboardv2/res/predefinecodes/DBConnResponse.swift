//
//  DBConnResponse.swift
//  dashboardKB
//
//  Created by Mohd Zulhilmi Mohd Zain on 23/03/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class DBConnResponse: NSObject {
    
    static func readConnectionResponse(fromViewController: UIViewController, responseReturn: NSDictionary) {
        
        print("[DBConnResponse] Checking connection (\(responseReturn))...")
        
        if(responseReturn.value(forKey: "GET_RESPONDED") as! Bool == false) {
            
            print("[DBConnResponse] Negative response")
            
            ZUIs.showOKDialogBox(viewController: fromViewController, dialogTitle: "Masalah sambungan", dialogMessage: "Terdapat masalah teknikal. Sila cuba sebentar lagi. (\(String(describing: responseReturn.value(forKey: "ERROR_CATCH")!)))", afterDialogDismissed: nil)
            
        }
        else {
            
            print("[DBConnResponse] Positive response")
            
        }
        
    }

}
