//
//  AppDelegate.swift
//  Pinder3
//
//  Created by LIPING on 5/7/21.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseMessaging
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
//    let gcmMessageIDKey = "gcm.message_id"
//    static var isToken: String? = nil
     

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        

        
        FirebaseApp.configure()
        configureInitialViewController()
        
        // set up back arrow in chat view
        UINavigationBar.appearance().tintColor = UIColor(red: 255/255, green: 144/255, blue: 198/255, alpha:1)
        let backImg = UIImage(named: "back")
        UINavigationBar.appearance().backIndicatorImage = backImg
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backImg
        // hiding the a back text
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset.init(horizontal: -1000, vertical: 0), for: UIBarMetrics.default)
        
 
        
//        //notification
//        if #available(iOS 14.0, *){
//            let current = UNUserNotificationCenter.current()
//            let options: UNAuthorizationOptions = [.sound, .badge, .alert]
//
//            current.requestAuthorization(options: options) { (grandted, error) in
//                if error != nil{
//
//                } else{
//                    Messaging.messaging().delegate = self
//                    current.delegate = self
//
//                    DispatchQueue.main.async{
//                        application.registerForRemoteNotifications()
//                    }
//                }
//            }
//        }
//        else{
//            let types: UIUserNotificationType = [.sound, .badge, .sound]
//            let settings = UIUserNotificationSettings(types: types, categories: nil)
//
//            application.registerUserNotificationSettings(settings)
//            application.registerForRemoteNotifications()
//        }
        return true
    }
    
    // auto login not working
    func configureInitialViewController() {
        self.window = UIWindow()
        self.window?.makeKeyAndVisible()
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var id: String
        
        if Auth.auth().currentUser != nil {
            id = IDENTIFIER_TABBAR
            print("TabBarVC")

        } else {
            id = IDENTIFIER_WELCOME
            print("WelcomeVC")
        }
        
        let initViewController: UIViewController = storyboard.instantiateViewController(withIdentifier: id)
//        window?.rootViewController = initViewController
        
        UIApplication.shared.windows.first?.rootViewController?.present(initViewController, animated: false, completion: nil)
        
        self.window?.makeKeyAndVisible()

    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        Api.User.isOnline(bool: false)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        Api.User.isOnline(bool: false)
//        Messaging.messaging().shouldEstablishDirectChannel = false
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//        connectToFirebase()
        Api.User.isOnline(bool: true)
//        connectToFirebase
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
//    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
//        if let messageId = userInfo[gcmMessageIDKey] {
//            print("messageId: \(messageId)")
//        }
//
//        print(userInfo)
//    }
//
//    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//        if let messageID = userInfo[gcmMessageIDKey] {
//            print("messageID: \(messageID)")
//        }
//        connectToFirebase()
//        Messaging.messaging().appDidReceiveMessage(userInfo)
//
//
//
//        completionHandler(UIBackgroundFetchResult.newData)
//    }
//
//    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        guard let token = AppDelegate.isToken else {
//            return
//        }
//        print("token: \(token)")
//    }
//
//    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
//        print(error.localizedDescription)
//    }
//
//    func connectToFirebase() {
//        Messaging.messaging().shouldEstablishDirectChannel = true
//    }
}



//extension AppDelegate: UNUserNotificationCenterDelegate, MessagingDelegate{
//    @available(iOS 14.0, *)
//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        let userInfo = notification.request.content.userInfo
//        if let message = userInfo[gcmMessageIDKey]{
//            print("Message: \(message)")
//        }
//        print(userInfo)
//
//        completionHandler([.sound, .badge, .banner])
//    }
//
//    private func messaging(_ messaging: Messaging, didReceiveRegisterationToken fcmToken: String){
//        guard let token = AppDelegate.isToken else{
//            return
//        }
//        print("Token: \(token)")
//    }
    
//    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage){
//        print("remoteMessage: \(remoteMessage.appData)")
//    }
//}
