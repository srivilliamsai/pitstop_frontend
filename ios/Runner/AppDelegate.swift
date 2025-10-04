import UIKit
import Flutter
import GoogleMaps  

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    //  Provide your actual Google Maps API key here
    GMSServices.provideAPIKey("YOUR_IOS_GOOGLE_MAPS_API_KEY")

    // Register all Flutter plugins
    GeneratedPluginRegistrant.register(with: self)

    // Continue app initialization
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}