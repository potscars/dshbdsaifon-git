//
//  DBSettings.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 06/12/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class DBSettings: NSObject {
    
    //Global Settings goes here
    
    static let dbLoginOS: String = "ios"
    
    //Main URLS
    
    static let mainURL: String = "http://dashboard.net.my"
    static let mySoalMainURL: String = "http://mysoal.pi1m.my"
    static let mySkoolMainURL: String = "http://myskool.pi1m.my"
    static let myShopMainURL: String = "http://myshop.pi1m.my"
    static let saifonURL: String = "http://saifon.my"
    
    //Sub URLS
    
    static let registerOnMobileURL: String = "\(mainURL)/api/session/register-mobile"
    static let loginURL: String = "\(mainURL)/mobile/session/login"
    static let loginFBURL: String = "\(mainURL)/mobile/session/login-fb"
    static let myKomunitiAdminURL: String = "\(mainURL)/api/announcement/hq-announcements/"
    static let myKomunitiPublicURL: String = "\(mainURL)/api/announcement/user-announcements/"
    static let mySoalTokenRetrievalURL: String = "\(mySoalMainURL)/messages/login_dashboardv2/"
    static let mySoalPetiMasukURL: String = "\(mySoalMainURL)/messages/dashboardv2_json_message/inbox/"
    static let mySkoolTokenRetrievalURL: String = "\(mySkoolMainURL)/users/dashboardv2_login/"
    static let mySkoolPetiMasukURL: String = "\(mySkoolMainURL)/walls/dashboardv2_json_wall/"
    static let myHealthBPURL: String = "\(mainURL)/api/myhealth/bp-records/"
    static let myHealthBWURL: String = "\(mainURL)/api/myhealth/weight-records/"
    static let myShopProductDetailsURL: String = "\(myShopMainURL)/api/product/find-product-detail"
    static let myShopLatestProductURL: String = "\(myShopMainURL)/api/product/latest-product-myshop"
    static let myShopPopularProductURL: String = "\(myShopMainURL)/api/product/popular"
    static let myShopHiRatingProductURL: String = "\(myShopMainURL)/api/product/all-product-review"
    static let myShopLocalProductURL: String = "\(myShopMainURL)/api/product/product-by-site"
    static let myShopProductImageThumbURL: String = "\(myShopMainURL)/productImage/thumbs"
    static let myShopProductImageLargeURL: String = "\(myShopMainURL)/productImage/large"
    static let apiSaifonTokenURL: String = "\(saifonURL)/api/mobile"
    static let apiSaifonWaterLevelURL: String = "\(saifonURL)/api/water-level-data"
    static let apiSaifonSensorFeedURL: String = "\(saifonURL)/api/libelium/latest-data"
    static let myKomunitiSendMsgURL: String = "\(mainURL)/api/announcement/add-announcement"
    static let aboutListAgenciesURL: String = "\(saifonURL)/api/list-agencies"
    
    //YTPlayer
    
    static let ytEmbeddedVideo: String = "-S3HyuE368Y"
    
}
