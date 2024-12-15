import Flutter
import UIKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      // Request permission for push notifications
          UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
              if granted {
                  DispatchQueue.main.async {
                      application.registerForRemoteNotifications()
                  }
              }
          }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
