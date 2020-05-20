import Flutter
import UIKit

public class SwiftWindowUtilsPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "window_utils", binaryMessenger: registrar.messenger())
    let instance = SwiftWindowUtilsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("SwiftWindowUtilsPlugin Not Avaliable on iOS")
  }
}
