import UIKit
import Flutter
import GoogleMaps
import Firebase

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    GeneratedPluginRegistrant.register(with: self)

    // Google Maps API key
    GMSServices.provideAPIKey("AIzaSyBXsZq7PL2lnJQ_SE2AFhxj7Zn-DiDjyi4")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
