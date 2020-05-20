import Cocoa
import FlutterMacOS

public class WindowUtils: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "window_utils", binaryMessenger: registrar.messenger)
        let instance = WindowUtils()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getWindowOffset":
            let window = NSApplication.shared.keyWindow
            let origin = window?.frame.origin
            var _output: [String: Any?] = [:]
            _output["offsetX"] = Double(origin?.x ?? 0)
            _output["offsetY"] = Double(origin?.y ?? 0)
            result(_output)
        case "getWindowSize":
            let window = NSApplication.shared.keyWindow
            let size = window?.frame.size
            var _output: [String: Any?] = [:]
            _output["width"] = Double(size?.width ?? 0)
            _output["height"] = Double(size?.height ?? 0)
            result(_output)
        case "getScreenSize":
            let window = NSApplication.shared.keyWindow
            let size = window?.screen?.frame.size
            var _output: [String: Any?] = [:]
            _output["width"] = Double(size?.width ?? 0)
            _output["height"] = Double(size?.height ?? 0)
            result(_output)
        case "hideTitleBar":
            if let window = NSApplication.shared.mainWindow
            {
                window.titleVisibility = .hidden
                window.styleMask.insert(.fullSizeContentView)
                window.titlebarAppearsTransparent = true
                window.contentView?.wantsLayer = true
                window.isMovableByWindowBackground = true
                window.isMovable = false
                result(true)
            } else {
                result(false)
            }
        case "showTitleBar":
            let window = NSApplication.shared.keyWindow
            window?.styleMask.update(with: .titled)
            result(true)
        case "windowTitleDoubleTap":
            let window = NSApplication.shared.keyWindow
            let isZoomed = window?.isZoomed ?? false
            window?.setIsZoomed(!isZoomed)
            result(true)
        case "closeWindow":
            let window = NSApplication.shared.keyWindow
            window?.close()
            result(true)
        case "centerWindow":
            let window = NSApplication.shared.keyWindow
            window?.center()
            result(true)
        case "setPosition":
            let args = call.arguments as? [String: Any]
            let x: Double = (args?["x"] as? Double)!
            let y: Double = (args?["y"] as? Double)!
            let point: NSPoint = NSPoint(x: x, y: y)
            let window = NSApplication.shared.keyWindow
            window?.setFrameOrigin(point)
            result(true)
        case "setSize":
            let args = call.arguments as? [String: Any]
            let width: Double = (args?["width"] as? Double)!
            let height: Double = (args?["height"] as? Double)!
            let size: NSSize = NSSize(width: width, height: height)
            let window = NSApplication.shared.keyWindow
            window?.setContentSize(size)
            result(true)
        case "startDrag":
            let window = NSApplication.shared.keyWindow
            if let event: NSEvent = window?.currentEvent
            {
                window?.performDrag(with: event)
            }
            result(true)
        case "childWindowsCount":
            let window = NSApplication.shared.keyWindow
            let count = window?.childWindows?.count ?? 0
            result(count)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
