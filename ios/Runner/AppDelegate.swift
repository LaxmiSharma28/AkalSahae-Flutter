import UIKit
import FirebaseCore
import FirebaseMessaging
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
     if FirebaseApp.app() == nil {
        FirebaseApp.configure()
     }

       if #available(iOS 12.0, *) {
             // For iOS 10 display notification (sent via APNS)
             UNUserNotificationCenter.current().delegate = self

             let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
             UNUserNotificationCenter.current().requestAuthorization(
               options: authOptions,
               completionHandler: { _, _ in }
             )
           } else {
             let settings: UIUserNotificationSettings =
               UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
             application.registerUserNotificationSettings(settings)
           }

           application.registerForRemoteNotifications()

//      //      FirebaseApp.configure()
//          return super.application(application, didFinishLaunchingWithOptions: launchOptions)


    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
