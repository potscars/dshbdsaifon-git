//
//  DBWebServices.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 06/12/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class DBWebServices: NSObject {
    
    static func checkConnectionToDashboard(viewController: AnyObject) -> Bool {
        
        if(ZNetwork.isConnectedToNetwork() == false)
        {
            print("[Libraries] No internet connection.")
            
            let alert = UIAlertController(title: "Masalah", message: "Sambungan Internet gagal. Sila periksa sambungan Internet anda.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action: UIAlertAction) -> Void in
                
            }))
            
            viewController.parent!!.present(alert, animated: true, completion: nil)
            
            return false
        }
        else
        {
            print("[Libraries] Has internet connection.")
            /*
            PlainPing.ping("http://dashboard.pi1m.my", withTimeout: 1.0, completionBlock: {(timeElapsed:Double?, error:Error?) in
            
                if let latency = timeElapsed {
                    
                    print("[DBWebServices] Ping detected in elapsed time \(latency)...")
                    
                }
                else if let error = error {
                    
                    print("[DBWebServices] Ping error: \(error.localizedDescription)")
                    
                }
            })
             */
            
            return true
        }
        
    }
    
    func simplePing(_ pinger: SimplePing, didStartWithAddress address: Data) {
        
        print("Starting pinging")
        
    }
    
    static func getRegistrationData(fromViewController: UIViewController, data: NSDictionary, registeredNotification: String) {
        
        let getLoginURL = NSURL.init(string: DBSettings.registerOnMobileURL)
        let getLoginParams = String(format: "ic_no=%@&full_name=%@&email=%@&password=%@&site_id=%@", data.value(forKey: "REG_IC_NO") as! String,data.value(forKey: "REG_FULL_NAME") as! String,data.value(forKey: "REG_EMAIL") as! String,data.value(forKey: "REG_PASSWORD") as! String,data.value(forKey: "REG_SITE_ID") as! String)
        
        print("[DBWS] Passed params are \(getLoginParams)")
        
        _ = ZNetwork.performPostData(url: getLoginURL!, parameters: getLoginParams, contentType: nil, includeContentLength: false, notificationName: registeredNotification)
        
    }
    
    static func getRegistrationFBData(fromViewController: UIViewController, data: NSDictionary, registeredNotification: String) {
        
        let getLoginURL = NSURL.init(string: DBSettings.loginFBURL)
        let getLoginParams = String(format: "username=%@&password=%@&os=%@&regid=%@&os_version=%@&imei=%@&type_login=%@&fb_id=%@&fb_token=%@&site_id=%@&full_name=%@&email=%@", data.value(forKey: "REG_USERNAME") as! String,data.value(forKey: "REG_PASSWORD") as! String,data.value(forKey: "REG_OS") as! String,data.value(forKey: "REG_ID") as! String,data.value(forKey: "REG_OS_VERSION") as! String,data.value(forKey: "REG_IMEI") as! String,data.value(forKey: "REG_TYPE_LOGIN") as! String,data.value(forKey: "REG_FB_ID") as! String,data.value(forKey: "REG_FB_TOKEN") as! String,data.value(forKey: "REG_SITE_ID") as! String,data.value(forKey: "REG_FULL_NAME") as! String,data.value(forKey: "REG_EMAIL") as! String)
        
        print("[DBWS] Passed params are \(getLoginParams)")
        
        _ = ZNetwork.performPostData(url: getLoginURL!, parameters: getLoginParams, contentType: nil, includeContentLength: false, notificationName: registeredNotification)
        
    }
    
    static func getLoginData(fromViewController: UIViewController, data: NSDictionary, registeredNotification: String) {
        
        let getLoginURL = NSURL.init(string: DBSettings.loginURL)
        let getLoginParams = String(format: "username=%@&password=%@&regid=%@&imei=%@&os=%@&os_version=%@", data.value(forKey: "USERNAME") as! String,data.value(forKey: "PASSWORD") as! String,data.value(forKey: "REGISTERED_ID") as! String,data.value(forKey: "IMEI") as! String,data.value(forKey: "OS") as! String,data.value(forKey: "OS_VERSION") as! String)
        
       _ = ZNetwork.performPostData(url: getLoginURL!, parameters: getLoginParams, contentType: nil, includeContentLength: false, notificationName: registeredNotification)
        
    }
    
    static func getLoginFBData(data: NSDictionary, registeredNotification: String) {
        
        let getLoginURL = NSURL.init(string: DBSettings.loginFBURL)
        let getLoginParams = String(format: "username=%@&password=%@&regid=%@&imei=%@&os=%@&os_version=%@&type_login=%@&site_id=%@&fb_id=%@&fb_token=%@", data.value(forKey: "USERNAME") as? String ?? "N/A",data.value(forKey: "PASSWORD") as? String ?? "N/A",data.value(forKey: "REGISTERED_ID") as? String ?? "N/A",data.value(forKey: "IMEI") as? String ?? "N/A",data.value(forKey: "OS") as? String ?? "N/A",data.value(forKey: "OS_VERSION") as? String ?? "N/A",data.value(forKey: "TYPE_LOGIN") as? String ?? "N/A",data.value(forKey: "SITE_ID") as? String ?? "N/A",data.value(forKey: "FB_ID") as? String ?? "N/A",data.value(forKey: "FB_TOKEN") as? String ?? "N/A")
        
        _ = ZNetwork.performPostData(url: getLoginURL!, parameters: getLoginParams, contentType: ZNetwork.ContentTypeApplicationXWWWFormUrlEncoded, includeContentLength: false, notificationName: registeredNotification)
    }
    
    static func getMyKomunitiAdminFeed(page: Int, registeredNotification: String) {
        
        //http://dashboard.pi1m.my/api/announcement/hq-announcements/{dash_token}/{dataperpage}
        
        let dashToken = UserDefaults.standard.object(forKey: "SuccessLoggerDashboardToken") as! String
        
        let getFeedParams = String(format: "%@/%@", dashToken, String(page))
        let getFeedURL = NSURL.init(string: "\(DBSettings.myKomunitiAdminURL)\(getFeedParams)")
        
        print("[DBWebServices] URL set: ",getFeedURL ?? "")
        
        _ = ZNetwork.performGetData(urlWithParameters: getFeedURL!, notificationName: registeredNotification)
    }
    
    static func getMyKomunitiPublicFeed(_ tableVC: UITableViewController, page: Int, registeredNotification: String) {
        
        //http://dashboard.pi1m.my/api/announcement/user-announcements/{dash_token}?page=1
        
        let dashToken = UserDefaults.standard.object(forKey: "SuccessLoggerDashboardToken") as! String
        
        let getFeedParams = String(format: "%@?page=%@", dashToken, String(page))
        let getFeedURL = NSURL.init(string: "\(DBSettings.myKomunitiPublicURL)\(getFeedParams)")
        
        print("[DBWebServices] URL set: ",getFeedURL ?? "")
        
        _ = ZNetwork.performGetData(urlWithParameters: getFeedURL!, notificationName: registeredNotification)
    }
    
    static func getMySoalToken(registeredNotification: String) {
        
        let dashToken = UserDefaults.standard.object(forKey: "SuccessLoggerDashboardToken") as! String
        
        let getLoginURL = NSURL.init(string: DBSettings.mySoalTokenRetrievalURL)!
        let getLoginParams = String(format: "dash_token=%@", dashToken)
        
        _ = ZNetwork.performPostData(url: getLoginURL, parameters: getLoginParams, contentType: ZNetwork.ContentTypeApplicationXWWWFormUrlEncoded, includeContentLength: true, notificationName: registeredNotification)
    }
    
    static func getMySoalFeed(tokenForMySoal: String, page: Int, registeredNotification: String) {
        
        let getMySoalURL = NSURL.init(string: "\(DBSettings.mySoalPetiMasukURL)page:\(page)")!
        let getMySoalData = String(format: "token=%@", tokenForMySoal)
        
        _ = ZNetwork.performPostData(url: getMySoalURL, parameters: getMySoalData, contentType: ZNetwork.ContentTypeApplicationXWWWFormUrlEncoded, includeContentLength: false, notificationName: registeredNotification)
    }
    
    static func getMySkoolToken(registeredNotification: String) {
        
        let dashToken = UserDefaults.standard.object(forKey: "SuccessLoggerDashboardToken") as! String
        
        let getLoginURL = NSURL.init(string: DBSettings.mySkoolTokenRetrievalURL)!
        let getLoginParams = String(format: "dash_token=%@", dashToken)
        
        _ = ZNetwork.performPostData(url: getLoginURL, parameters: getLoginParams, contentType: ZNetwork.ContentTypeApplicationXWWWFormUrlEncoded, includeContentLength: true, notificationName: registeredNotification)
    }
    
    static func getMySkoolInboxFeed(tokenForMySkool: String, page: Int, registeredNotification: String) {
        
        let getFeedParams = String(format: "%@/page:%@", tokenForMySkool, String(page))
        let getFeedURL = NSURL.init(string: "\(DBSettings.mySkoolPetiMasukURL)\(getFeedParams)")
        
        print("[DBWebServices] URL set: ",getFeedURL ?? "")
        
        _ = ZNetwork.performGetData(urlWithParameters: getFeedURL!, notificationName: registeredNotification)
    }
    
    static func getMyHealthBPFeed(page: Int, registeredNotification: String) {
        
        let dashToken = UserDefaults.standard.object(forKey: "SuccessLoggerDashboardToken") as! String
        
        let getFeedParams = String(format: "%@/page=%@", dashToken, String(page))
        let getFeedURL = NSURL.init(string: "\(DBSettings.myHealthBPURL)\(getFeedParams)")
        
        print("[DBWebServices] URL set: ",getFeedURL ?? "")
        
        _ = ZNetwork.performGetData(urlWithParameters: getFeedURL!, notificationName: registeredNotification)
    }
    
    static func getMyHealthBWFeed(page: Int, registeredNotification: String) {
        
        let dashToken = UserDefaults.standard.object(forKey: "SuccessLoggerDashboardToken") as! String
        
        let getFeedParams = String(format: "%@/page=%@", dashToken, String(page))
        let getFeedURL = NSURL.init(string: "\(DBSettings.myHealthBWURL)\(getFeedParams)")
        
        print("[DBWebServices] URL set: ",getFeedURL ?? "")
        
        _ = ZNetwork.performGetData(urlWithParameters: getFeedURL!, notificationName: registeredNotification)
    }
    
    static func getMyShopLatestProdFeed(page: Int, registeredNotification: String) {
        
        let getFeedParams = String(format: "?page=%@", String(page))
        let getFeedURL = NSURL.init(string: "\(DBSettings.myShopLatestProductURL)\(getFeedParams)")
        
        print("[DBWebServices] URL set: ",getFeedURL ?? "")
        
        _ = ZNetwork.performGetData(urlWithParameters: getFeedURL!, notificationName: registeredNotification)
    }
    
    static func getMyShopPopularProdFeed(page: Int, registeredNotification: String) {
        
        let getFeedParams = String(format: "?page=%@", String(page))
        let getFeedURL = NSURL.init(string: "\(DBSettings.myShopPopularProductURL)\(getFeedParams)")
        
        print("[DBWebServices] URL set: ",getFeedURL ?? "")
        
        _ = ZNetwork.performGetData(urlWithParameters: getFeedURL!, notificationName: registeredNotification)
    }
    
    static func getMyShopHiRatingProdFeed(page: Int, registeredNotification: String) {
        
        let getFeedParams = String(format: "?page=%@", String(page))
        let getFeedURL = NSURL.init(string: "\(DBSettings.myShopHiRatingProductURL)\(getFeedParams)")
        
        print("[DBWebServices] URL set: ",getFeedURL ?? "")
        
        _ = ZNetwork.performGetData(urlWithParameters: getFeedURL!, notificationName: registeredNotification)
    }
    
    static func getMyShopLocalProdFeed(registeredNotification: String) {
        
        let dashToken = UserDefaults.standard.object(forKey: "SuccessLoggerDashboardToken") as! String
        
        let getFeedParams = String(format: "?token=%@", dashToken)
        let getFeedURL = NSURL.init(string: "\(DBSettings.myShopLocalProductURL)\(getFeedParams)")
        
        print("[DBWebServices] URL set: ",getFeedURL ?? ""," and Token: ",dashToken )
        
        _ = ZNetwork.performGetData(urlWithParameters: getFeedURL!, notificationName: registeredNotification)
    }
    
    static func getMyShopProductDetails(productID: Int, registeredNotification: String) {
        
        let getFeedParams = String(format: "%@", String(productID))
        let getFeedURL = NSURL.init(string: "\(DBSettings.myShopProductDetailsURL)/\(getFeedParams)")
        
        print("[DBWebServices] URL set: ",getFeedURL ?? "")
        
        _ = ZNetwork.performGetData(urlWithParameters: getFeedURL!, notificationName: registeredNotification)
    }
    
    static func getWaterLevelFeed(amount: Int, registeredNotification: String) {
        
        let getFeedParams = String(format: "?amount=%@", String(amount))
        let getFeedURL = NSURL.init(string: "\(DBSettings.apiSaifonWaterLevelURL)\(getFeedParams)")
        
        print("[DBWebServices] URL set: ",getFeedURL ?? "")
        
        _ = ZNetwork.performGetData(urlWithParameters: getFeedURL!, notificationName: registeredNotification)
    }
    
    static func getSensorFeed(amount: Int, registeredNotification: String) {
        
        //let getFeedParams = String(format: "?amount=%@", String(amount))
        let getFeedURL = NSURL.init(string: "\(DBSettings.apiSaifonSensorFeedURL)")
        
        print("[DBWebServices] URL set: ",getFeedURL ?? "")
        
        _ = ZNetwork.performGetData(urlWithParameters: getFeedURL!, notificationName: registeredNotification)
    }
    
    static func sentAnnouncementMyKomuniti(registeredNotification: String, images: NSArray, content: String) {
        
        let dashToken = UserDefaults.standard.object(forKey: "SuccessLoggerDashboardToken") as! String
        
        let getAnnouncementURL = NSURL.init(string: DBSettings.myKomunitiSendMsgURL)!
        //let getAnnouncementParams = String(format: "token=%@&content=%@&attachments[]=%@",dashToken,content,images)
        //let getAnnouncementParams = "token=\(dashToken)&content=\(content)&attachments[]=\(images)"
        let getAnnouncementParams = "token=\(dashToken)&content=\(content)&attachments[]=\(images)"
        
        print("[DBWebServices] URL set: ",getAnnouncementParams )
        
        _ = ZNetwork.performPostData(url: getAnnouncementURL, parameters: getAnnouncementParams, contentType: nil, includeContentLength: false, notificationName: registeredNotification)
    }
    
    static func getAgenciesList(registeredNotification: String) {
        
        let getListURL: NSURL = NSURL.init(string: DBSettings.aboutListAgenciesURL)!
        
        _ = ZNetwork.performGetData(urlWithParameters: getListURL, notificationName: registeredNotification)
        
    }
}












