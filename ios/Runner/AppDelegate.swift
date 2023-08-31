import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    // Google Maps API key
    GMSServices.provideAPIKey("AIzaSyBXsZq7PL2lnJQ_SE2AFhxj7Zn-DiDjyi4")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
