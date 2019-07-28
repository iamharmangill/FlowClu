//
//  AppDelegate.swift
//  FlowClu
//
//  Created by Harman Gill on 2019-06-07.
//  Copyright © 2019 Harman Gill. All rights reserved.
//

import UIKit
import Firebase
import FirebaseInstanceID
import FirebaseMessaging
import GoogleSignIn
import FirebaseFirestore
import UserNotifications



let primaryColor = UIColor(red: 98/255, green: 50/255, blue: 50/255, alpha: 1)
let secondaryColor = UIColor(red: 5/255, green: 72/255, blue: 62/255, alpha: 1)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    
    var window: UIWindow?
    let sender = PushNotificationSender()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self

        
//        // PN Firebase
        
//        // PN Firebase End
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//        for token in tokenData {
//            sender.sendPushNotification(to: token, title: "PLEASE", body: "BE working")
//        }
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication:options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                                 annotation:options [UIApplication.OpenURLOptionsKey.annotation])
        
        
    }
    
    
    
    // Notifications Start
//
//    func getNotificationSettings() {
//        UNUserNotificationCenter.current().getNotificationSettings { settings in
//            print("Notification settings: \(settings)")
//            guard settings.authorizationStatus == .authorized else { return }
//            DispatchQueue.main.async {
//                UIApplication.shared.registerForRemoteNotifications()
//            }
//
//        }
//    }
//
//
//    func registerForPushNotifications() {
//        UNUserNotificationCenter.current()
//            .requestAuthorization(options: [.alert, .sound, .badge]) {
//                [weak self] granted, error in
//
//                print("Permission granted: \(granted)")
//                guard granted else { return }
//                self?.getNotificationSettings()
//        }
//
//    }
//
//    func application(
//        _ application: UIApplication,
//        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
//        ) {
////        self.sendDeviceTokenToServer(data: deviceToken)
//        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
//        let token = tokenParts.joined()
//        print("Device Token: \(token)")
//    }
//
//    func application(
//        _ application: UIApplication,
//        didFailToRegisterForRemoteNotificationsWithError error: Error) {
//        print("Failed to register: \(error)")
//    }
//
//
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        // Define the custom actions.
//        print(response)
////        let acceptAction = UNNotificationAction(identifier: "ACCEPT_ACTION",
////                                                title: "Accept",
////                                                options: UNNotificationActionOptions(rawValue: 0))
////        let declineAction = UNNotificationAction(identifier: "DECLINE_ACTION",
////                                                 title: "Decline",
////                                                 options: UNNotificationActionOptions(rawValue: 0))
////        // Define the notification type
////        let meetingInviteCategory =
////            UNNotificationCategory(identifier: "MEETING_INVITATION",
////                                   actions: [acceptAction, declineAction],
////                                   intentIdentifiers: [],
////                                   hiddenPreviewsBodyPlaceholder: "",
////                                   options: .customDismissAction)
////        // Register the notification type.
////        let notificationCenter = UNUserNotificationCenter.current()
////        notificationCenter.setNotificationCategories([meetingInviteCategory])
//    }
    
    // Notifications End
    
    
    // PN Firebase
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        
        let dataDict:[String: String] = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("Received data message: \(remoteMessage.appData)")
    }
    
    // PN Firebase End
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        if let error = error {
            // ...
            print("=============================Start===========================")
            print("login success", error)
            print(error.localizedDescription)
            print("=============================end===========================")
            
        } else {
            guard let authentication = user.authentication else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                           accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if error == nil {
                    print(authResult?.user.email as Any )
                    print(authResult?.user.displayName as Any)
                    // ...
                    
                }
                else
                {
                    print(error?.localizedDescription as Any)
                }
                // User is signed i
                // ...
            }
        }
        
        // User is signed in
        // ...
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
    }
    
    // Push Notifications Start Here..
    func applicationReceivedRemoteMessage(_ remoteMessage: MessagingRemoteMessage) {
        print(remoteMessage.appData)
    }
}
