//
//  AppDelegate.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 25/11/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FacebookCore
import Compass
import Firebase
import UserNotifications
import GoogleMaps
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {

    var window: UIWindow?
    static var mainMenuController: UIViewController?
    static var loginController: UIViewController?
    static var moduleAvailable: NSArray = ["MODULE_MYKOMUNITI","MODULE_WATERLEVEL","MODULE_WEATHER"]
    let gcmMessageIDKey = "gcm.message_id"
    let googleMapsAPIKey = "AIzaSyAkOFY2J1Kc57yWfexI52uc7aohW-SUKXQ"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        //UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        
        print("[AppDelegate] Detected OS: \(UIDevice.current.systemName) \n Detected OS Version: \(UIDevice.current.systemVersion)")
        
        self.registerForPushNotifications(application)
        FirebaseApp.configure()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.tokenRefreshNotification), name: NSNotification.Name.InstanceIDTokenRefresh, object: nil)
        
        GMSServices.provideAPIKey(googleMapsAPIKey)
        GMSPlacesClient.provideAPIKey(googleMapsAPIKey)
        
        listingAllFontNames()
        
        Navigator.scheme = "compass"
        Navigator.routes = ["profile:{username}","login:{username}","logout"]
        
        return true
    }
    
    func registerForPushNotifications(_ application: UIApplication) {
        
        if #available(iOS 10.0, *) {
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: { (granted, error) in
                guard error == nil else {
                    print("Noti register error: \(error?.localizedDescription)")
                    return
                }
                if granted {
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                        print("Noti registered!")
                    }
                } else {
                    
                    print("Failed to registered!")
                }
            })
            
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            // For iOS 10 data message (sent via FCM)
            Messaging.messaging().delegate = self
            
        } else {
            let userNotificationTypes: UIUserNotificationType = [.alert, .badge, .sound]
            let settings = UIUserNotificationSettings(types: userNotificationTypes, categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
    func application(received remoteMessage: MessagingRemoteMessage) {
        
        print("[Firebase] Message received: \(remoteMessage)")
        
    }
    
    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        if notificationSettings.types != UIUserNotificationType() {
            application.registerForRemoteNotifications()
        }
        
        print("App notification registered.")
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        //MARK : - Firebase
        let tokenChars = (deviceToken as NSData).bytes.bindMemory(to: CChar.self, capacity: deviceToken.count)
        var tokenString = ""
        
        for i in 0..<deviceToken.count {
            tokenString += String(format: "%02.2hhx", arguments: [tokenChars[i]])
        }
        
        //Tricky line
        Messaging.messaging().apnsToken = deviceToken
        print("Device Token:", tokenString)
        
    }

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("FCM Token: \(fcmToken)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        print(userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    @objc func tokenRefreshNotification(notification: NSNotification) {
        //    NOTE: It can be nil here
        if let token = InstanceID.instanceID().token() {
            print("InstanceID token: \(token)")
            
        }
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let handled: Bool = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[.sourceApplication] as! String, annotation: options[.annotation])
        
        return handled
        //return false
    }
    
    func listingAllFontNames() {
        
        for familyName in UIFont.familyNames {
            
            for fontName in UIFont.fontNames(forFamilyName: familyName) {
                
                print("[AppDelegate] Family font name to use: \(fontName)")
                
            }
        }
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        AppEventsLogger.activate(application)
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

