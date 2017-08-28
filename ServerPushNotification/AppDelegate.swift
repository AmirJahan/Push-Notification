import UIKit
import NotificationCenter
import UserNotifications
import Firebase
import FirebaseInstanceID
import FirebaseMessaging

// You need to be a paid apple developer

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        registerForPushNotifications()
        
        FirebaseApp.configure()
        return true
    }
    
    
    
    // Asking user for permissions
    func registerForPushNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            print("Permission granted: \(granted)")
            
            guard granted else { return }
            
            // 1
            let myAction = UNNotificationAction(identifier: "action ID",
                                                title: "Don't Do IT!",
                                                options: [.foreground])
            
            // 2
            let myCategory = UNNotificationCategory(identifier: "cat_id",
                                                    actions: [myAction],
                                                    intentIdentifiers: [],
                                                    options: [])
            // 3
            UNUserNotificationCenter.current().setNotificationCategories([myCategory])
            
            self.getNotificationSettings()
        }
    }
    
    
    // checking the current settings
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            print("Notification settings: \(settings)")
            guard settings.authorizationStatus == .authorized else { return }
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
    
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        
        let token = tokenParts.joined()
        print("Token is: \(token)")
    }
    
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed: \(error)")
    }
    
    
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void)    {
        
        print("You can do what you want to do with data in here")
        
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        //        let userInfo = response.notification.request.content.userInfo
        //        let aps = userInfo["aps"] as! [String: AnyObject]
        
        print("You can do what you want to do with data in here")
        
        completionHandler()
    }
}
