import Cocoa
import FlutterMacOS

public class WinTrackerPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "win_tracker", binaryMessenger: registrar.messenger)
    let eventChannel = FlutterEventChannel(name: "win_tracker_keyboard", binaryMessenger: messenger!)
              eventChannel.setStreamHandler(SwiftStreamHandler())
    let instance = WinTrackerPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("macOS " + ProcessInfo.processInfo.operatingSystemVersionString)
    case "isAccessAllowed":
        isAccessAllowed(call, result: result)
        break
    case "requestPermission":
        requestAccess(call, result: result)
        break
    case "screenCapture":
        screenCapture(call, result: result)
        break
    default:
      result(FlutterMethodNotImplemented)
    }
  }
    
  public func isAccessAllowed(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
            if #available(macOS 10.16, *) {
                result(CGPreflightScreenCaptureAccess())
                return
            };
            result(true)
  }
    private func getDirectory(ofType directory: FileManager.SearchPathDirectory) -> String? {
      let paths = NSSearchPathForDirectoriesInDomains(
        directory,
        FileManager.SearchPathDomainMask.userDomainMask,
        true)
      return paths.first
    }
    
  public func screenCapture(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      let args:[String: Any] = call.arguments as! [String: Any]
      let fileName: String = args["fileName"] as! String
      let filePath: String = args["filePath"] as! String
            let imgPath: String = filePath+"/"+fileName
        print("\(imgPath)")
        let destt = URL(fileURLWithPath: imgPath)
          let destination = getDirectory(ofType: FileManager.SearchPathDirectory.libraryDirectory)!
            
          let img = CGDisplayCreateImage(CGMainDisplayID())
                       let dest = CGImageDestinationCreateWithURL(destt as CFURL, kUTTypePNG, 1, nil)
                      try? CGImageDestinationAddImage(dest!, img!, nil)
                       CGImageDestinationFinalize(dest!)

            print("\(imgPath)")
            result(true)
  }
    
  public func requestAccess(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
            let args:[String: Any] = call.arguments as! [String: Any]
            let onlyOpenPrefPane: Bool = args["onlyOpenPrefPane"] as! Bool

            if (!onlyOpenPrefPane) {
                if #available(macOS 10.16, *) {
                    CGRequestScreenCaptureAccess()
                } else {
                    // Fallback on earlier versions
                }
            } else {
                let prefpaneUrl = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_ScreenCapture")!
                NSWorkspace.shared.open(prefpaneUrl)
            }
            result(true)
  }
}
